local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	extensions = {
		repo = {
			list = {
				search_dirs = {
					"~/sio/cfg_mgmt",
					"~/sio/dp/",
					"~/sio/cst/",
					"~/.config/nvim",
					"~/dotfiles",
				},
			},
		},
	},
})

-- Use fzf sorter
require("telescope").load_extension("fzf")

-- Repository switcher
require("telescope").load_extension("repo")

-- Find files
map("n", "<Leader>t", ":Telescope find_files<CR>", { silent = true })

-- Search for string under cursor
map("n", "<Leader>*", ":Telescope grep_string<CR>", { silent = true })

-- Live grep while typing
map("n", "<Leader>a", ":Telescope live_grep<CR>", { silent = true })

-- Find in current buffer
map("n", "<Leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })

-- Help pages
map("n", "<Leader>h", ":Telescope help_tags<CR>", { silent = true })

-- Switch repos
map("n", "<Leader>r", ":Telescope repo list<CR>", { silent = true })
