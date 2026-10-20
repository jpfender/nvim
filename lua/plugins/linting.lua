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
        sh = { "shellcheck" },
        yaml = { "yamllint" },
      })

      local lint = require("lint")
      local default = vim.deepcopy(lint.linters.sqlfluff)
      default.stream = "both"
      lint.linters.sqlfluff = function()
        local linter = vim.deepcopy(default)
        local project = require("config.pipenv").resolve()
        if project then
          linter.cmd = project.python
          linter.args = vim.list_extend({ "-m", "sqlfluff" }, linter.args or {})
          linter.cwd = project.root
          linter.env = project.env
        end
        return linter
      end
    end,
  },
}
