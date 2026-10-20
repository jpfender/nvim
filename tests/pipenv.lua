vim.opt.rtp:prepend(vim.fn.getcwd())

local tmp = vim.fn.tempname()
vim.fn.mkdir(tmp, "p")
tmp = assert(vim.uv.fs_realpath(tmp))
local original_env = vim.fn.environ()
local original_cwd = vim.fn.getcwd()
local failures = {}

local function write(path, lines, executable)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines, path)
  if executable then
    vim.fn.setfperm(path, "rwx------")
  end
end

local repo = tmp .. "/repo with spaces"
local nested = repo .. "/service"
local sibling = repo .. "/other"
local root_venv = tmp .. "/root-env"
local child_venv = tmp .. "/child-env"
write(repo .. "/Pipfile", { "[packages]" })
write(nested .. "/Pipfile", { "[packages]" })
write(sibling .. "/Pipfile", { "[packages]" })
for _, venv in ipairs({ root_venv, child_venv }) do
  write(venv .. "/bin/python", {
    "#!/bin/sh",
    'printf \'%s\\n\' "$VIRTUAL_ENV" "$PWD" "$@" > "$VIRTUAL_ENV/invocation"',
    'cat "$VIRTUAL_ENV/invocation"',
    'if [ "$2" = sqlfluff ] && [ "$3" = format ]; then printf "\\n-- formatted\\n" >> "$4"; fi',
  }, true)
end
write(tmp .. "/bin/pipenv", {
  "#!/bin/sh",
  'printf "lookup\\n" >> "' .. tmp .. '/lookups"',
  'test "$1" = "--venv" || exit 20',
  'test "$PIPENV_IGNORE_VIRTUALENVS" = "1" || exit 21',
  'test "$PIPENV_PIPFILE" = "$PWD/Pipfile" || exit 22',
  'case "$PWD" in',
  '  "' .. nested .. '") printf "%s\\n" "' .. child_venv .. '" ;;',
  '  "' .. repo .. '") printf "%s\\n" "' .. root_venv .. '" ;;',
  '  *) echo "No virtualenv has been created" >&2; exit 1 ;;',
  "esac",
}, true)
vim.env.PATH = tmp .. "/bin:" .. original_env.PATH
vim.env.VIRTUAL_ENV = root_venv
vim.env.PIPENV_ACTIVE = "1"
vim.env.PIPENV_PIPFILE = repo .. "/Pipfile"
vim.fn.chdir(repo)

local function test(name, fn)
  local ok, err = pcall(fn)
  if not ok then
    failures[#failures + 1] = name .. ": " .. tostring(err)
  end
end

test("nearest Pipfile wins over cwd and inherited environment", function()
  local pipenv = require("config.pipenv")
  local project = assert(pipenv.resolve(nested .. "/src/new.py"))
  assert(project.root == nested, vim.inspect(project))
  assert(project.python == child_venv .. "/bin/python", vim.inspect(project))
  local result = vim
    .system({ project.python, "-m", "sqlfluff" }, {
      cwd = project.root,
      env = project.env,
      clear_env = true,
      text = true,
    })
    :wait()
  assert(result.code == 0, result.stderr)
  assert(result.stdout == child_venv .. "\n" .. nested .. "\n-m\nsqlfluff\n", result.stdout)
  assert(vim.env.VIRTUAL_ENV == root_venv)
  assert(vim.fn.getcwd() == repo)
end)

test("successful lookups are cached separately per Pipfile", function()
  local pipenv = require("config.pipenv")
  assert(pipenv.resolve(repo .. "/root.py").python == root_venv .. "/bin/python")
  assert(pipenv.resolve(nested .. "/another.py").python == child_venv .. "/bin/python")
  assert(#vim.fn.readfile(tmp .. "/lookups") == 2)
  pipenv.clear_cache()
  assert(pipenv.resolve(nested .. "/another.py").python == child_venv .. "/bin/python")
  assert(#vim.fn.readfile(tmp .. "/lookups") == 3)
  assert(vim.uv.fs_utime(nested .. "/Pipfile", 1000000000, 1000000000))
  assert(pipenv.resolve(nested .. "/another.py").python == child_venv .. "/bin/python")
  assert(#vim.fn.readfile(tmp .. "/lookups") == 4)
end)

test("missing nested environments fail instead of using the parent environment", function()
  local pipenv = require("config.pipenv")
  local ok, err = pcall(pipenv.resolve, sibling .. "/file.py")
  assert(not ok, "incorrectly used a parent environment")
  assert(tostring(err):find("No virtualenv", 1, true), tostring(err))
  assert(pipenv.resolve(nested .. "/file.py").python == child_venv .. "/bin/python")
end)

test("paths without Pipfiles and unnamed buffers do not select a project", function()
  local pipenv = require("config.pipenv")
  assert(pipenv.resolve(tmp .. "/outside/new.py") == nil)
  assert(pipenv.resolve("") == nil)
end)

test("SQLFluff resolves from its buffer, not the editor working directory", function()
  vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/nvim-lint")
  local opts = { linters_by_ft = {} }
  dofile(original_cwd .. "/lua/plugins/linting.lua")[1].opts(nil, opts)
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, nested .. "/src/file.py")
  vim.api.nvim_set_current_buf(buf)
  local linter = require("lint").linters.sqlfluff()
  assert(linter.cmd == child_venv .. "/bin/python", vim.inspect(linter))
  assert(linter.cwd == nested, vim.inspect(linter))
  assert(linter.args[1] == "-m" and linter.args[2] == "sqlfluff", vim.inspect(linter.args))
  assert(linter.env.VIRTUAL_ENV == child_venv)
  vim.api.nvim_buf_delete(buf, { force = true })
end)

test("missing lint modules produce visible errors", function()
  local linter = require("lint").linters.sqlfluff()
  assert(linter.stream == "both", "Python module errors on stderr would be discarded")
  local diagnostics = linter.parser("python: No module named sqlfluff", 0)
  assert(diagnostics[1].message:find("No module named sqlfluff", 1, true))
end)

test("ty uses a separate Pipfile root and explicit interpreter", function()
  local specs = dofile(original_cwd .. "/lua/plugins/lsp.lua")
  local opts = { servers = {} }
  for _, spec in ipairs(specs) do
    if spec[1] == "neovim/nvim-lspconfig" then
      spec.opts(nil, opts)
    end
  end
  local config = assert(opts.servers.ty, "ty is not configured")
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_buf_set_name(buf, nested .. "/file.py")
  local root
  config.root_dir(buf, function(value)
    root = value
  end)
  assert(root == nested, tostring(root))
  local client_config = { root_dir = root, settings = {} }
  local client_settings = client_config.settings
  config.before_init({}, client_config)
  assert(client_settings.ty.configuration.environment.python == child_venv .. "/bin/python")
  vim.api.nvim_buf_delete(buf, { force = true })
end)

test("Neotest runs the selected test's environment even with a different focused buffer", function()
  for _, plugin in ipairs({ "neotest-python", "neotest", "nvim-nio", "plenary.nvim" }) do
    vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/" .. plugin)
  end
  local opts = { adapters = { ["neotest-python"] = {} } }
  dofile(original_cwd .. "/lua/plugins/neotest.lua")[1].opts(nil, opts)
  local adapter = opts.adapters[1]
  local path = nested .. "/tests/test_example.py"
  assert(adapter.root(path) == nested)
  local done, failure
  require("nio").run(function()
    local spec = adapter.build_spec({
      strategy = "integrated",
      tree = {
        data = function()
          return { path = path, id = path, type = "file" }
        end,
      },
    })
    spec.context.stop_stream()
    assert(spec.command[1] == child_venv .. "/bin/python", vim.inspect(spec.command))
    assert(spec.cwd == nested, tostring(spec.cwd))
    assert(spec.env.VIRTUAL_ENV == child_venv)
  end, function(ok, err)
    done = true
    if not ok then
      failure = err
    end
  end)
  assert(
    vim.wait(5000, function()
      return done
    end),
    "Neotest build timed out"
  )
  assert(not failure, tostring(failure))
end)

test("SQL formatting uses the saved buffer's project and reloads that buffer", function()
  dofile(original_cwd .. "/lua/config/autocmds.lua")
  local path = nested .. "/models/query with spaces.sql"
  write(path, { "select 1" })
  local buf = vim.fn.bufadd(path)
  vim.fn.bufload(buf)
  vim.api.nvim_exec_autocmds("BufWritePost", { buffer = buf })
  assert(
    vim.wait(5000, function()
      return vim.api.nvim_buf_get_lines(buf, -2, -1, false)[1] == "-- formatted"
    end),
    "formatted SQL was not reloaded"
  )
  assert(
    table.concat(vim.fn.readfile(child_venv .. "/invocation"), "\n")
      == child_venv .. "\n" .. nested .. "\n-m\nsqlfluff\nformat\n" .. path
  )
  vim.api.nvim_buf_delete(buf, { force = true })
end)

vim.fn.chdir(original_cwd)
for key in pairs(vim.fn.environ()) do
  vim.env[key] = original_env[key]
end
for key, value in pairs(original_env) do
  vim.env[key] = value
end
vim.fn.delete(tmp, "rf")
if #failures > 0 then
  io.stderr:write(table.concat(failures, "\n") .. "\n")
  vim.cmd("cquit 1")
else
  print("Pipenv isolation tests passed")
  vim.cmd("qa!")
end
