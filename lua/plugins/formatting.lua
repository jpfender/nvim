return {
  {
    "conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, {
        lua = { "stylua" },
        markdown = { "markdownlint" },
        python = { "isort", "black" }, -- TODO: Revisit ruff
        sh = { "shfmt" },
        -- TODO: sqlfluff
        sql = { "sqlfluff" },
        terraform = { "terraform_fmt" },
        toml = { "taplo" },
      })
      opts.formatters = vim.tbl_extend("force", opts.formatters, {
        sqlfluff = {
          command = "pipenv",
          args = {
            "run",
            "sqlfluff",
            "format",
            "$FILENAME",
            "--dialect=redshift",
            "--templater=dbt",
          },
        },
      })
      opts.format.async = true
    end,
  },
}
