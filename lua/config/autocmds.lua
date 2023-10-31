-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("jp_" .. name, { clear = true })
end

-- Automatically switch to correct pipenv for buffer
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup("pipenv"),
  callback = function()
    require("pipenv").set_pipenv()
  end,
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
  callback = function()
    vim.fn.jobstart("pipenv run sqlfluff format " .. vim.api.nvim_buf_get_name(0))
  end,
})
