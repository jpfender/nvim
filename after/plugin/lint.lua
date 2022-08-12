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
