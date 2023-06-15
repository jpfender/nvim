return {
  "lualine.nvim",
  opts = function(_, opts)
    opts.options = vim.tbl_extend("force", opts.options, {
      globalstatus = false,
    })
    opts.sections.lualine_x = vim.tbl_extend("force", opts.sections.lualine_x, {
      { "pipenv", icon = "" },
    })
  end,
}
