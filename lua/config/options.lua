-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- Text width, line wrapping etc
opt.tw = 100 -- Set text width to 100
opt.wrap = true -- Enable line wrap

-- FIX: this doesn't work. Figure out why
-- opt.linebreak = true
-- opt.breakindent = true -- Indent wrapped lines

-- A - Suppress swapfile messages
-- F - Suppress "file written" messages
-- s - No "search hit BOTTOM, continuing at TOP" messages
opt.shortmess:append({ s = true, A = true, F = true })
