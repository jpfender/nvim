-- disable telescope
if true then
  return {}
end

return {
  {
    "telescope.nvim",

    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "debugloop/telescope-undo.nvim",
        config = function()
          require("telescope").load_extension("undo")
        end,
      },
    },

    opts = function(_, opts)
      local actions = require("telescope.actions")
      -- Set some custom mappings
      opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, {
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      })
    end,
  },
}
