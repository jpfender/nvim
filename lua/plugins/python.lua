return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {
          -- Make sure pyright uses pyproject.toml as the root indicator
          -- Otherwise it will use the nearest Pipfile, which will mess up LazyVim's root
          root_dir = function(fname)
            local util = require("lspconfig/util")
            local root_files = {
              "pyproject.toml",
            }
            return util.root_pattern(unpack(root_files))(fname)
              or util.find_git_ancestor(fname)
              or util.path.dirname(fname)
          end,
        },
        -- NOTE: Ruff seems a little immature for now. Keep an eye on it
        -- ruff_lsp = {
        --   init_options = {
        --     settings = {
        --       args = { "--line-length=100" },
        --     },
        --   },
        -- },
      },
    },
  },
  {
    "mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "isort")
      table.insert(opts.ensure_installed, "black")
    end,
  },
  {
    "null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.formatting.isort,
        nls.builtins.formatting.black.with({
          -- Make black respect local pyproject.toml
          cwd = function(params)
            return vim.fn.fnamemodify(params.bufname, ":h")
          end,
        }),
        nls.builtins.diagnostics.pydocstyle,
        nls.builtins.diagnostics.flake8,
        nls.builtins.diagnostics.pylint,
      })
    end,
  },
  {
    "jpfender/pipenv.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
