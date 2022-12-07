-- Select linter by filetype
require("lint").linters_by_ft = {
	cloudformation = { "cfn_lint", "cfn_nag" },
	gitcommit = { "commitlint" },
	groovy = { "npm-groovy-lint" },
	javascript = { "eslint" },
	lua = { "luacheck" },
	markdown = { "vale" },
	python = { "pylint", "flake8" },
	sh = { "shellcheck" },
	sql = { "sqlfluff" },
	yaml = { "yamllint" },
}

-- Automatically lint after writing
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
