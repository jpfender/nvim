-- Highlight current line
vim.opt.cursorline = true

-- Only highlight cursorline in focused window
vim.api.nvim_command([[
augroup highlight_follows_focus
    autocmd WinEnter * set cursorline
    autocmd WinEnter * set hlsearch
    autocmd WinLeave * set nocursorline
augroup END
]])
