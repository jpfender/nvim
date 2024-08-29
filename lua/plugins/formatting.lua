return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, {
        lua = { "stylua" },
        python = { "isort", "ruff_fix", "black" },
        sh = { "shfmt" },
        sql = {},
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
      })
      opts.formatters = vim.tbl_extend("force", opts.formatters, {
        ["markdownlint-cli2"] = {},
      })
    end,
  },
}
