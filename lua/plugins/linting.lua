return {
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft, {
        ansible = { "ansible_lint" },
        cfn = { "cfn_lint", "cfn_nag" }, -- TODO: Set cfn ft in autocmds.lua
        gitcommit = { "commitlint" },
        groovy = { "npm-groovy-lint" },
        json = { "jsonlint" },
        lua = { "luacheck" },
        -- TODO: Checkmake for Makefiles?
        python = { "pylint" },
        sh = { "shellcheck" },
        yaml = { "yamllint" },
      })

      require("lint").linters.sqlfluff.cmd = "pipenv"
      require("lint").linters.sqlfluff.args =
        vim.list_extend({ "run", "sqlfluff" }, require("lint").linters.sqlfluff.args)
    end,
  },
}
