return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ignore_filetypes, { "markdown" })
    end,
  },
}
