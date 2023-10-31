return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, {
        lua = { "stylua" },
        markdown = { "markdownlint" },
        python = { "isort", "black" }, -- TODO: Revisit ruff
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
      })
    end,
  },
}
