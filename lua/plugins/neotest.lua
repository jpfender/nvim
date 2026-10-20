return {
  {
    "neotest",
    opts = function(_, opts)
      local python = require("neotest-python")
      local config = vim.tbl_deep_extend("force", opts.adapters["neotest-python"] or {}, {
        dap = { justMyCode = false },
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
      })
      opts.adapters["neotest-python"] = false

      -- The adapter's python callback receives a pytest root, which may sit above a nested Pipfile.
      local function adapter_for(path)
        local project = require("config.pipenv").resolve(path)
        local adapter_config = vim.deepcopy(config)
        if project then
          adapter_config.python = project.python
          adapter_config.dap.env = project.env
          adapter_config.dap.cwd = project.root
        end
        return python(adapter_config), project
      end

      local adapter = python(config)
      local default_root = adapter.root
      adapter.root = function(path)
        return require("config.pipenv").root(path) or default_root(path)
      end
      adapter.discover_positions = function(path)
        return adapter_for(path).discover_positions(path)
      end
      adapter.build_spec = function(args)
        local selected, project = adapter_for(args.tree:data().path)
        local spec = selected.build_spec(args)
        if project then
          spec.cwd = project.root
          spec.env = project.env
        end
        return spec
      end
      table.insert(opts.adapters, adapter)
    end,
  },
}
