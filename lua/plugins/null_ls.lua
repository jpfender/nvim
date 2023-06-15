-- Various null-ls integrations
return {
  {
    "null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- Ansible
        nls.builtins.diagnostics.ansiblelint,
        -- Cloudformation
        nls.builtins.diagnostics.cfn_lint,
        -- Docker
        nls.builtins.diagnostics.hadolint,
        -- Groovy
        nls.builtins.diagnostics.npm_groovy_lint,
        nls.builtins.formatting.npm_groovy_lint,
        -- JSON
        nls.builtins.formatting.jq,
        -- Makefiles
        nls.builtins.diagnostics.checkmake,
        -- ShellCheck
        nls.builtins.diagnostics.shellcheck,
        nls.builtins.code_actions.shellcheck,
        -- SQLFluff
        nls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "redshift", "--templater", "dbt" },
          to_temp_file = false,
          timeout = 180000,
          -- filter = function(diagnostic)
          --   return not type(diagnostic) == "string" and not string.find(diagnostic, "Unable to do partial parsing")
          -- end,
        }),
        -- YAML
        nls.builtins.diagnostics.yamllint,
      })
    end,
  },
}
