return {
  {
    "nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft, {
        ansible = { "ansible_lint" },
        cfn = { "cfn_lint", "cfn_nag" }, -- TODO: Set cfn ft in autocmds.lua
        gitcommit = { "commitlint" },
        groovy = { "npm-groovy-lint" },
        json = { "jsonlint" },
        lua = { "luacheck" },
        -- TODO: Checkmake for Makefiles?
        python = { "pydocstyle", "pylint" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        yaml = { "yamllint" },
      })
      opts.linters = vim.tbl_extend("force", opts.linters, {
        sqlfluff = {
          cmd = "pipenv",
          args = {
            "run",
            "sqlfluff",
            "lint",
            "--format=json",
            "--dialect=redshift",
            "--templater=dbt",
          },
        },
      })
    end,
  },
}
