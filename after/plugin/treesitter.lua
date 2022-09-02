require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"dockerfile",
		"fish",
		"gitignore",
		"help",
		"javascript",
		"jsdoc",
		"json",
		"lua",
		"make",
		"markdown",
		"python",
		"rust",
		"sql",
		"typescript",
		"vim",
		"yaml",
	},
	-- Automatically install missing parsers when entering buffer
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	playground = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
		},
	},
})
