-- Utilities for creating configurations
local util = require("formatter.util")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Provides the Format and FormatWrite commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		fish = {
			require("formatter.filetypes.fish").fishindent,
		},
		javascript = {
			require("formatter.filetypes.javascript").prettiereslint,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		markdown = {
			require("formatter.filetypes.markdown").prettier,
		},
		python = {
			require("formatter.filetypes.python").isort,
			require("formatter.filetypes.python").black,
		},
		rust = {
			require("formatter.filetypes.rust").rustfmt,
		},
		yaml = {
			require("formatter.filetypes.yaml").prettier,
		},
	},
})

-- Remove trailing whitespace before saving
local whitespace_group = augroup("whitespace_group", {})
autocmd({ "BufWritePre" }, {
	group = whitespace_group,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Format
autocmd({ "BufWritePost" }, { command = "FormatWriteLock" })
