-- Italicize comments
vim.highlight.create("Comment", { cterm = "italic", gui = "italic" }, false)

vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

local colors = require("catppuccin.palettes").get_palette()

require("catppuccin").setup({
	custom_highlights = {
		Comment = { fg = colors.overlay1 },
		LineNr = { fg = colors.overlay1 },
	},
})

vim.cmd([[colorscheme catppuccin]])
