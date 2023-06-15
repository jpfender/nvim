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

-- Refactoring: https://github.com/ThePrimeagen/refactoring.nvim
-- Remaps for the refactoring operations currently offered by the plugin
map(
  "v",
  "<leader>re",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract function" }
)
map(
  "v",
  "<leader>rf",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract function to file" }
)
map(
  "v",
  "<leader>rv",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract variable" }
)
map(
  "v",
  "<leader>ri",
  [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Inline variable" }
)

-- Extract block doesn't need visual mode
map(
  "n",
  "<leader>rb",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract block" }
)
map(
  "n",
  "<leader>rbf",
  [[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Extract block to file" }
)

-- Inline variable can also pick up the identifier currently under the cursor without visual mode
map(
  "n",
  "<leader>ri",
  [[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
  { noremap = true, silent = true, expr = false, desc = "Inline variable" }
)

-- You can also use below = true here to to change the position of the printf
-- statement (or set two remaps for either one). This remap must be made in normal mode.
map(
  "n",
  "<leader>rp",
  ":lua require('refactoring').debug.printf({below = false})<CR>",
  { noremap = true, desc = "Debug: Mark function call" }
)

-- Print var

-- Remap in normal mode and passing { normal = true } will automatically find the variable under the cursor and print it
map(
  "n",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({ normal = true })<CR>",
  { noremap = true, desc = "Debug: Print var" }
)
-- Remap in visual mode will print whatever is in the visual selection
map(
  "v",
  "<leader>rv",
  ":lua require('refactoring').debug.print_var({})<CR>",
  { noremap = true, desc = "Debug: Print visual selection" }
)

-- Cleanup function: this remap should be made in normal mode
map(
  "n",
  "<leader>rc",
  ":lua require('refactoring').debug.cleanup({})<CR>",
  { noremap = true, desc = "Debug: Clean up" }
)
