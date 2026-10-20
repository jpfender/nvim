local M = {}
local cache = {}

function M.root(path)
  path = path or vim.api.nvim_buf_get_name(0)
  if path == "" or path:match("^%w+://") then
    return nil
  end
  path = vim.fs.normalize(vim.fn.fnamemodify(path, ":p"))
  local stat = vim.uv.fs_stat(path)
  local directory = stat and stat.type == "directory" and path or vim.fs.dirname(path)
  local pipfile = vim.fs.find("Pipfile", { path = directory, upward = true, type = "file" })[1]
  return pipfile and vim.fs.dirname(pipfile) or nil
end

function M.clear_cache()
  cache = {}
end

function M.resolve(path)
  local root = M.root(path)
  if not root then
    return nil
  end

  local pipfile = root .. "/Pipfile"
  local mtime = assert(vim.uv.fs_stat(pipfile)).mtime
  local cached = cache[root]
  local venv
  if cached and vim.deep_equal(cached.mtime, mtime) and vim.fn.executable(cached.venv .. "/bin/python") == 1 then
    venv = cached.venv
  else
    local result = vim
      .system({ "pipenv", "--venv" }, {
        cwd = root,
        env = { PIPENV_IGNORE_VIRTUALENVS = "1", PIPENV_PIPFILE = pipfile },
        text = true,
      })
      :wait(5000)
    if result.code ~= 0 then
      local detail = vim.trim((result.stderr or "") .. "\n" .. (result.stdout or ""))
      error(("Pipenv lookup failed for %s (exit %d): %s"):format(pipfile, result.code, detail), 0)
    end
    venv = vim.trim(result.stdout or "")
    if venv == "" or vim.fn.executable(venv .. "/bin/python") ~= 1 then
      error("Pipenv returned no usable Python environment for " .. pipfile, 0)
    end
    cache[root] = { venv = venv, mtime = mtime }
  end

  local env = vim.fn.environ()
  env.VIRTUAL_ENV = venv
  env.PATH = venv .. "/bin:" .. (env.PATH or "")
  env.PYTHONHOME = nil
  env.PIPENV_ACTIVE = nil
  env.PIPENV_IGNORE_VIRTUALENVS = "1"
  env.PIPENV_PIPFILE = pipfile
  return { root = root, venv = venv, python = venv .. "/bin/python", env = env }
end

return M
