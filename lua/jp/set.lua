local prefix = vim.env.XDG_CONFIG_HOME or vim.fn.expand("~/.config")

-- Make Vim use zsh as its builtin shell, as fish doesn't support all of the fancy stuff some
-- extensions want it to do
vim.opt.shell = "/bin/zsh"

-- Allow backspacing over everything in insert mode
vim.opt.backspace = { "indent", "eol", "start" }

-- Show cursor position at all times
vim.opt.ruler = true

-- Undo and backup
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.local/share/nvim/backup//"

-- Display incomplete commands
vim.opt.showcmd = true

-- Do incremental searching
vim.opt.incsearch = true

-- Enable mouse
vim.opt.mouse = "a"

-- Dark background
vim.opt.background = "dark"

-- List of sane defaults, mostly from tpope/wincent
vim.opt.laststatus = 2
vim.opt.encoding = "utf-8"
vim.opt.wrapscan = true
vim.opt.ai = true
vim.opt.nu = true
vim.opt.linebreak = true
vim.opt.fillchars = {
	diff = "·",
}
vim.opt.wildmenu = true

-- Set textwidth to 100
vim.opt.tw = 100

-- Sane case settings for search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Scroll settings
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
-- TODO set display+=lastline

-- Wincent's listchars
vim.opt.listchars = {
	tab = "▷┅",
	nbsp = "⦸",
	trail = "•",
	extends = "»",
	precedes = "«",
}

vim.opt.autoread = true

-- Do not redraw screen while running macros
vim.opt.lazyredraw = true

-- Fast redraw screen
vim.opt.ttyfast = true

-- s - No "search hit BOTTOM, continuing at TOP" messages
-- A - Suppress swapfile messages
vim.opt.shortmess = "sA"

-- tcq   default options if not set here
--
-- t +   Auto-wrap text using textwidth
-- c +   Auto-wrap comments using textwidth, inserting the current
--       comment leader automatically.
-- r +   Automatically insert the current comment leader after
-- 	hitting <Enter> in Insert mode.
-- q +   Allow formatting of comments with "gq".
--       Note that formatting will not change blank lines or lines
--       containing only the comment leader.  A new paragraph
--       starts after such a line, or when the comment leader
--       changes.
-- n +   When formatting text, recognize numbered lists.  This actually
--       uses the 'formatlistpat' option, thus any kind of list can be
--       used. The indent of the text after the number is used for the
--       next line. The default is to find a number, optionally followed
--       by '.', ':', ')', " ']' or 'curly bracket'.  Note that
--       'autoindent' must be set too.  Doesn't work well with "2".
--           Example: >
--               1. the first item
--                  wraps
--               2. the second item
-- l -   Long lines are not broken in insert mode: When a line was
--       longer than 'textwidth' when the insert command started, Vim
--       does not automatically format it.
-- 1 +   Don't break a line after a one-letter word. It's broken before
--       it instead (if possible).
-- j +   Remove comment leader when joining comment lines
vim.opt.formatoptions = "tcrqnl1j"

-- Paste mode with visual feedback
vim.opt.pastetoggle = "<F2>"
vim.opt.showmode = true

-- Replace tabs with spaces
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Don't autoinsert two spaces after '.', '?', '!' for join command
vim.opt.joinspaces = false

-- Show relative line numbers in gutter
vim.opt.number = true
vim.opt.relativenumber = true

-- Always indent by multiples of shiftwidth
vim.opt.shiftround = true

-- Extra info at end of command line
vim.opt.showcmd = true

-- <tab>/<BS> indent/dedent in leading whitespace
vim.opt.smarttab = true

-- Disable all bells
vim.opt.belloff = "all"

-- Try to reuse windows/tabs when switching buffers
vim.opt.switchbuf = "usetab"

-- Allow liberal line boundary crossing
vim.opt.whichwrap = "bs<>[]~"

-- Enable system clipboard
vim.opt.clipboard = "unnamed"

-- Force full width emoji
vim.opt.emoji = false

-- Don't insert first completion result on CR
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- Highlight search results
vim.opt.hlsearch = true

-- Disable syntax concealing, esp. for markdown files
vim.opt.conceallevel = 0

-- Highlight text on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank({ timeout = 300 })")
