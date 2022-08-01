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
})

-- Use fzf sorter
require("telescope").load_extension("fzf")

-- Find files
map("n", "<Leader>t", ":Telescope find_files<CR>", { silent = true })

-- Search for string under cursor
map("n", "<Leader>*", ":Telescope grep_string<CR>", { silent = true })

-- Live grep while typing
map("n", "<Leader>a", ":Telescope live_grep<CR>", { silent = true })

-- Find in current buffer
map("n", "<Leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })
