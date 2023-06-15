-- Refactoring based on Martin Fowler's book
-- https://github.com/ThePrimeagen/refactoring.nvim
return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_extend("force", opts.defaults, {
        ["<leader>r"] = { name = "+refactoring" },
      })
    end,
  },
}
