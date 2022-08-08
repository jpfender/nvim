-- Print only the containing directory without the filename, replacing $HOME with '~'
local function stripped_path()
	local path = vim.fn.expand("%:p:h")
	path = path:gsub(vim.fn.expand("~"), "~")
	return path
end

-- Print filename
local function filename()
	local fname = vim.fn.expand("%:t")
	if vim.bo.modified then
		fname = fname .. " [+]"
	end
	return fname
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		-- Visually distinguish path and file name
		lualine_c = {
			{
				stripped_path,
				color = {
					gui = "italic",
				},
			},
			{
				filename,
				color = function(section)
					return {
						gui = "bold",
						fg = vim.bo.modified and "#aa3355" or "#33aa88",
					}
				end,
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		-- Visually distinguish path and file name
		lualine_c = { { stripped_path, color = { gui = "italic" } }, { filename, color = { gui = "bold" } } },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {
		lualine_a = {
			{
				"tabs",
				mode = 2,
			},
		},
	},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
