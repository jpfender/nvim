local lsp = require("lsp-zero")

lsp.preset("recommended")
lsp.nvim_workspace()

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
end)

-- luasnip setup
local luasnip = require("luasnip")

-- VSCode-like symbols
local lspkind = require("lspkind")

-- Enable LSP-signature
require("lsp_signature").setup({})

-- nvim-cmp setup
local cmp = require("cmp")
local cmp_buffer = require("cmp_buffer")

local cmp_mappings = lsp.defaults.cmp_mappings({
	-- Automatically insert completions into buffer when I start pressing tab
	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	-- Always show menu, do not autoselect first item
	completion = {
		completeopt = "menuone,noselect,noinsert",
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{
			name = "buffer",
			keyword_length = 3,
			option = {
				-- Complete from all open buffers
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end,
			},
		},
		{ name = "tmux" },
		{ name = "luasnip", keyword_length = 2 },
	},
	-- Configure lspkind
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
	-- Sort suggestions by locality
	sorting = {
		comparators = {
			function(...)
				return cmp_buffer:compare_locality(...)
			end,
		},
	},
})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
