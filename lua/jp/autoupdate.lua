-- Weekly auto updates
vim.cmd([[
function! OnVimEnter() abort
    let l:filename = printf('%s/.vim_packer_update', expand("$HOME"))
    if filereadable(l:filename) == 0
        call writefile([], l:filename)
    endif

    let l:this_week = strftime('%Y_%V')
    let l:contents = readfile(l:filename)
    if index(l:contents, l:this_week) < 0
        call execute('PackerSync')
        call writefile([l:this_week], l:filename, 'a')
    endif
endfunction

autocmd VimEnter * call OnVimEnter()
]])
