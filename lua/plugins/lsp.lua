return {
  -- Default language servers
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-lint",
        "black",
        "cfn-lint",
        "commitlint",
        "fixjson",
        "flake8",
        "hadolint",
        "isort",
        "jsonlint",
        "luacheck",
        "markdownlint",
        "prettier",
        "pydocstyle",
        "shellcheck",
        "shfmt",
        "stylua",
        "taplo",
        "yamllint",
      },
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          prefix = "icons",
        },
        severity_sort = true,
      },
      codelens = {
        enabled = true,
      },
      inlay_hints = {
        enabled = true,
      },
    },
  },
}
