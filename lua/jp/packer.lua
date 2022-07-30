-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	---------------------------------------------------------------------
	-- META -------------------------------------------------------------
	---------------------------------------------------------------------

	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	---------------------------------------------------------------------
	-- TREESITTER -------------------------------------------------------
	---------------------------------------------------------------------
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	---------------------------------------------------------------------
	-- GIT --------------------------------------------------------------
	---------------------------------------------------------------------

	-- Gutter signs (signify replacement)
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame_opts = {
					delay = 0,
				},
			})
		end,
	})

	-- Lazygit
	use("kdheepak/lazygit.nvim")

	-- Diffview
	use({
		"sindrets/diffview.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("diffview").setup()
		end,
	})

	---------------------------------------------------------------------
	-- UI ---------------------------------------------------------------
	---------------------------------------------------------------------

	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Seamless switching between vim splits and tmux panes
	use({
		"aserowy/tmux.nvim",
		config = function()
			require("tmux").setup({
				copy_sync = {
					-- enables copy sync and overwrites all register actions to
					-- sync registers *, +, unnamed, and 0 till 9 from tmux in advance
					enable = true,
				},
				navigation = {
					-- enables default keybindings (C-hjkl) for normal mode
					enable_default_keybindings = true,
				},
				resize = {
					-- enables default keybindings (A-hjkl) for normal mode
					enable_default_keybindings = true,
				},
			})
		end,
	})

	-- colorschemes
	use("RRethy/nvim-base16")
	use("folke/tokyonight.nvim")

	-- Better highlighting of search results
	use("wincent/loupe")

	-- Motions
	use({
		"phaazon/hop.nvim",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- Indent lines
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				char_highlight_list = { "Comment" },
				use_treesitter = true,
			})
		end,
	})

	-- Fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

	-- File tree
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons",
		},
		tag = "nightly",
		config = function()
			require("nvim-tree").setup({
				git = {
					enable = true,
					ignore = true,
					timeout = 500,
				},
			})
		end,
	})

	-- Rainbow parentheses
	use("p00f/nvim-ts-rainbow")

  -- Highlight word under cursor
  use 'RRethy/vim-illuminate'

	---------------------------------------------------------------------
	-- EDITING ----------------------------------------------------------
	---------------------------------------------------------------------

	-- Autoclose parentheses etc
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- Abolish: :Subvert etc
	use("tpope/vim-abolish")

	-- Automatically guess indentation
	use({
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	})

	-- Capslock
	use({
		"barklan/capslock.nvim",
		config = function()
			require("capslock").setup()
		end,
	})

	-- Undotree - there doesn't seem to be a lua native replacement for Mundo
	use("simnalamburt/vim-mundo")

	-- Surround
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					normal = "sa",
					delete = "sd",
					change = "sr",
				},
			})
		end,
	})

	-- Commenting
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				toggler = {
					line = "<Leader>cc",
				},
				opleader = {
					line = "<Leader>c",
				},
			})
		end,
	})

	-- Align text
	use("tommcdo/vim-lion")

	-- Additional text objects
	use("wellle/targets.vim")

	-- Strip trailing whitespace
	-- XXX possibly made redundant by formatter.nvim
	-- use({
	--   "mcauley-penney/tidy.nvim",
	--   config = function()
	--     require("tidy").setup()
	--   end
	-- })

	-- Re-open files at last position
	use({
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup()
		end,
	})

	-- Sorting
	use({
		"sQVe/sort.nvim",
		config = function()
			require("sort").setup()
		end,
	})

	---------------------------------------------------------------------
	-- STARTUP ----------------------------------------------------------
	---------------------------------------------------------------------

	-- Alpha-nvim (startify replacement)
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	})

	---------------------------------------------------------------------
	-- LSP, COMPLETION & SNIPPETS --------------------------------------------
	---------------------------------------------------------------------

	use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin

	-- Quickfix for LSP
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({})
		end,
	})

	-- VSCode-like symbols
	use("onsails/lspkind.nvim")

	-- Completion sources:
	-- Buffer
	use("hrsh7th/cmp-buffer")
	-- Path
	use("hrsh7th/cmp-path")
	-- Tmux
	use("andersevenrud/cmp-tmux")
	-- Neovim Lua API
	use("hrsh7th/cmp-nvim-lua")

	-- Formatting
	use("mhartington/formatter.nvim")

	---------------------------------------------------------------------
	-- UNCLEAR IF NEED --------------------------------------------------
	---------------------------------------------------------------------
	-- 'Shougo/context_filetype.vim'
	-- 'dag/vim-fish'
	-- quickfix stuff??
	-- bracketed paste? -> wincent/terminus
	-- formatting -> neoformat or LSP?
end)
