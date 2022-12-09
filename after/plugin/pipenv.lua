-- Automatically switch to any pipenv associated with the open buffer
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		require("pipenv").set_pipenv()
	end,
})
