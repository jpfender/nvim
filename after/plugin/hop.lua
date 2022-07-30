-- Hop wordwise
map('n', '<Leader>w', ':HopWordAC<CR>', { silent = true })
map('n', '<Leader>b', ':HopWordBC<CR>', { silent = true })

-- Hop to ends of words
vim.api.nvim_set_keymap('n', '<Leader>e', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, direction = require'hop.hint'.HintDirection.AFTER_CURSOR })<cr>", { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>E', "<cmd>lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", { silent = true })

-- Hop right or left in current line only
map('n', '<Leader>l', ':HopWordCurrentLineAC<CR>', { silent = true })
map('n', '<Leader>h', ':HopWordCurrentLineBC<CR>', { silent = true })

-- Hop up or down lines
-- map('n', '<Leader>k', ':HopLineBC<CR>', { silent = true })
-- map('n', '<Leader>j', ':HopLineAC<CR>', { silent = true })

-- Hop anywhere in any window
map('n', '<Leader>o', ':HopWordMW<CR>', { silent = true })
