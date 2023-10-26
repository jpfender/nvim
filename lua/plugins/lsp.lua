return {
  -- Default language servers
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-lint",
        "black",
        "cfn-lint",
        "commitlint",
        "fixjson",
        "flake8",
        "groovy-language-server",
        "hadolint",
        "isort",
        "jsonlint",
        "luacheck",
        "markdownlint",
        "prettier",
        "pydocstyle",
        "pyright",
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
    },
  },
}
