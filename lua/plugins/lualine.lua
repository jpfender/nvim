return {
  "lualine.nvim",
  opts = function(_, opts)
    opts.options = vim.tbl_extend("force", opts.options, {
      globalstatus = false,
    })
    opts.sections.lualine_x = vim.tbl_extend("force", opts.sections.lualine_x, {
      {
        function()
          local root = require("config.pipenv").root()
          return root and vim.fs.basename(root) or ""
        end,
        icon = "",
      },
    })
  end,
}
