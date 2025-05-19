-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Always center search results
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "*", "*zz")
map("n", "#", "#zz")

-- Use | and _ to split windows (while preserving original behaviour of [count]bar and [count]_).
map(
  "n",
  "<Bar>",
  'v:count == 0 ? "<C-W>v<C-W><Right>" : ":<C-U>normal! 0".v:count."<Bar><CR>"',
  { expr = true, silent = true }
)
map("n", "_", 'v:count == 0 ? "<C-W>s<C-W><Down>"  : ":<C-U>normal! ".v:count."_<CR>"', { expr = true, silent = true })

-- Easily maximize splits
map("n", "<C-w>m", "<C-w>_<C-w>|")

-- Tmux navigation
map(
  "n",
  "<C-h>",
  "<cmd>lua require('tmux').move_left()<cr>",
  { noremap = true, silent = true, desc = "Tmux navigate left" }
)
map(
  "n",
  "<C-j>",
  "<cmd>lua require('tmux').move_bottom()<cr>",
  { noremap = true, silent = true, desc = "Tmux navigate down" }
)
map(
  "n",
  "<C-k>",
  "<cmd>lua require('tmux').move_top()<cr>",
  { noremap = true, silent = true, desc = "Tmux navigate up" }
)
map(
  "n",
  "<C-l>",
  "<cmd>lua require('tmux').move_right()<cr>",
  { noremap = true, silent = true, desc = "Tmux navigate right" }
)

-- Tmux resizing
map(
  "n",
  "<A-h>",
  "<cmd>lua require('tmux').resize_left()<cr>",
  { noremap = true, silent = true, desc = "Tmux resize left" }
)
map(
  "n",
  "<A-j>",
  "<cmd>lua require('tmux').resize_bottom()<cr>",
  { noremap = true, silent = true, desc = "Tmux resize down" }
)
map(
  "n",
  "<A-k>",
  "<cmd>lua require('tmux').resize_top()<cr>",
  { noremap = true, silent = true, desc = "Tmux resize up" }
)
map(
  "n",
  "<A-l>",
  "<cmd>lua require('tmux').resize_right()<cr>",
  { noremap = true, silent = true, desc = "Tmux resize right" }
)

-- Obsidian Daily Note
map(
  "n",
  "<leader>no",
  "<cmd>exe 'e ~/Documents/Obsidian Vault/'.strftime('%Y-%m-%d').'.md'<cr>",
  { noremap = true, silent = true, desc = "Open Obsidian daily note" }
)
map(
  "n",
  "<leader>ns",
  "<cmd>exe 'vsplit ~/Documents/Obsidian Vault/'.strftime('%Y-%m-%d').'.md'<cr>",
  { noremap = true, silent = true, desc = "Open Obsidian daily note in split" }
)
