-- CloudFormation
require('lint').linters.cfn_lint = {
    cmd = 'cfn-lint',
    stdin = true,
}
require('lint').linters.cfn_nag_scan = {
    cmd = 'cfn_nag_scan --input-path',
    stdin = false,
}

-- Select linter by filetype
require('lint').linters_by_ft = {
    ansible = { 'ansible_lint' },
    cloudformation = { 'cfn_lint', 'cfn_nag_scan' },
    javascript = { 'eslint' },
    lua = { 'luacheck' },
    markdown = { 'vale' },
    python = { 'pylint', 'flake8' },
    yaml = { 'yamllint' },
}

-- Automatically lint after writing
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
