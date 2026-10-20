return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.ty = vim.tbl_deep_extend("force", opts.servers.ty or {}, {
        settings = { ty = {} },
        root_dir = function(bufnr, on_dir)
          local path = vim.api.nvim_buf_get_name(bufnr)
          local ok, project = pcall(require("config.pipenv").resolve, path)
          if not ok then
            vim.notify(project, vim.log.levels.ERROR)
            return
          end
          on_dir(
            project and project.root
              or vim.fs.root(path, { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" })
              or vim.fs.dirname(path)
          )
        end,
        before_init = function(_, config)
          local project = require("config.pipenv").resolve(config.root_dir)
          if project then
            config.settings = config.settings or {}
            config.settings.ty = vim.tbl_deep_extend("force", config.settings.ty or {}, {
              configuration = { environment = { python = project.python } },
            })
          end
        end,
      })
    end,
  },
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
