-- Open horizontal splits below, vertical splits to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
map('n', '<Bar>', 'v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"', { expr = true, silent = true })
map('n', '_'    , 'v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"'     , { expr = true, silent = true })

-- Easily maximize splits
map('n', '<C-w>m', '<C-w>_<C-w>|')

-- Automatically resize splits when vim is resized
vim.api.nvim_command([[
autocmd VimResized * execute "normal! \<c-w>="
]])
