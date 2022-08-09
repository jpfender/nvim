-- CloudFormation

local cfn_lint_pattern = "([^:]+):(%d+):(%d+):(%d+):(%d+):(%w)(%d+):(.*)"
local cfn_lint_groups = { "file", "lnum", "col", "end_lnum", "end_col", "severity", "code", "message" }
local cfn_lint_severity_map = {
	["W"] = vim.diagnostic.severity.WARN,
	["E"] = vim.diagnostic.severity.ERROR,
}

require("lint").linters.cfn_lint = {
	cmd = "cfn-lint",
	args = { "--format", "parseable" },
	stdin = false,
	parser = require("lint.parser").from_pattern(
		cfn_lint_pattern,
		cfn_lint_groups,
		cfn_lint_severity_map,
		{ ["source"] = "cfn-lint" }
	),
}

-- Select linter by filetype
require("lint").linters_by_ft = {
	cloudformation = { "cfn_lint" },
	javascript = { "eslint" },
	lua = { "luacheck" },
	markdown = { "vale" },
	python = { "pylint", "flake8" },
	yaml = { "yamllint" },
}

-- Automatically lint after writing
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
