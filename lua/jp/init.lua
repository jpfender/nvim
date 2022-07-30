require('jp.set')
require('jp.keymap')
require('jp.packer')
require('jp.autoupdate')
require('jp.cursorline')
require('jp.splits')
require('jp.lsp')
require('jp.completion')

vim.cmd('colorscheme base16-phd')

-- Italicize comments
vim.highlight.create('Comment', {cterm='italic', gui='italic'}, false)
