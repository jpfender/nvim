return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      vim.keymap.set(
        "n",
        "<leader>hm",
        ":lua require('harpoon.mark').add_file()<CR>",
        { noremap = true, silent = true, expr = false, desc = "Mark file" }
      )
      vim.keymap.set(
        "n",
        "<leader>hf",
        ":lua require('harpoon.ui').toggle_quick_menu()<CR>",
        { noremap = true, silent = true, expr = false, desc = "Find mark" }
      )
    end,
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_extend("force", opts.defaults, {
        ["<leader>h"] = { name = "+Harpoon" },
      })
    end,
  },
}
