return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.pyright = {
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
      }
    end,
  },
  {
    "jpfender/pipenv.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
