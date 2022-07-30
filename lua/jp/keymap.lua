-- UNIVERSAL MAPPINGS

-- Map leader to space
vim.g.mapleader = ' '

-- Don't use Ex mode, use Q for formatting
map('', 'Q', 'gq')

-- CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
map('i', '<C-U>', '<C-G>u<C-U>')

-- Use tab to jump between bracket pairs
map('n', '<tab>', '%')
map('v', '<tab>', '%')

-- Repurpose cursor keys to jump through quickfix list
map('n', '<Up>'   , ':cprevious<CR>', { silent = true })
map('n', '<Down>' , ':cnext<CR>'    , { silent = true })
map('n', '<Left>' , ':cpfile<CR>'   , { silent = true })
map('n', '<Right>', ':cnfile<CR>'   , { silent = true })

-- Store relative line number jumps in the jumplist if they exceed a threshold
map("n", "k", "(v:count > 5 ? \"m'\" . v:count : '') . 'gk'", { expr = true })
map("n", "j", "(v:count > 5 ? \"m'\" . v:count : '') . 'gj'", { expr = true })
map("v", "j", "gj")
map("v", "k", "gk")

-- Show the path of the current file
map('n', '<Leader>p', ':echo expand("%")<CR>')

-- Don't lose selection when shifting sidewards
map('x', '<', '<gv')
map('x', '>', '>gv')

-- Go to tab by number
map('', '<Leader>1', '1gt')
map('', '<Leader>2', '2gt')
map('', '<Leader>3', '3gt')
map('', '<Leader>4', '4gt')
map('', '<Leader>5', '5gt')
map('', '<Leader>6', '6gt')
map('', '<Leader>7', '7gt')
map('', '<Leader>8', '8gt')
map('', '<Leader>9', '9gt')
map('', '<Leader>0', ':tablast<CR>')

-- Copy to clipboard
map('v', '<Leader>y', '"+y')
map('n', '<Leader>y', '"+y')

-- ThePrimeagen's remappings
map('n', 'Y', 'y$')
map('n', 'J', 'mzJ`z')

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map('n', '<Leader>j', ':m .+1<CR>==')
map('n', '<Leader>k', ':m .-2<CR>==')

-- Easily close tab
map('n', '<C-x>', ':tabclose<CR>')
