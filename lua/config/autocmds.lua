-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("jp_" .. name, { clear = true })
end

vim.api.nvim_create_user_command("PipenvClearCache", function()
  require("config.pipenv").clear_cache()
end, {
  desc = "Refresh Pipenv environments on the next tool invocation",
})

-- yaml.ansible filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("filetype_ansible"),
  pattern = { "*aws/*yml" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "filetype", "yaml.ansible")
  end,
})

-- cfn filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("filetype_cfn"),
  pattern = { "*template_*.yaml" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "filetype", "yaml.cfn")
  end,
})

-- sqlfluff format
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup("sqlfluff"),
  pattern = { "*.sql" },
  callback = function(event)
    local path = vim.api.nvim_buf_get_name(event.buf)
    local ok, project = pcall(require("config.pipenv").resolve, path)
    if not ok then
      vim.notify(project, vim.log.levels.ERROR)
      return
    end
    local command = project and { project.python, "-m", "sqlfluff", "format", path } or { "sqlfluff", "format", path }
    vim.system(command, {
      cwd = project and project.root or vim.fs.dirname(path),
      env = project and project.env or nil,
      clear_env = project ~= nil,
      text = true,
    }, function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          local detail = vim.trim((result.stderr or "") .. "\n" .. (result.stdout or ""))
          vim.notify(("SQLFluff formatting failed (exit %d): %s"):format(result.code, detail), vim.log.levels.ERROR)
        elseif vim.api.nvim_buf_is_valid(event.buf) and not vim.bo[event.buf].modified then
          vim.api.nvim_buf_call(event.buf, function()
            vim.cmd("checktime")
          end)
        end
      end)
    end)
  end,
})

-- Autosave Obsidian notes on insert leave
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
  group = augroup("obsidian"),
  pattern = { "*/Obsidian Vault/*" },
  callback = function()
    if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
      vim.cmd("silent w")
    end
  end,
})
