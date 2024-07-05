return {
  {
    "overseer.nvim",
    opts = function()
      require("overseer").register_template({
        name = "git checkout",
        params = function()
          local stdout = vim.system({ "git", "branch", "--format=%(refname:short)" }):wait().stdout
          local branches = vim.split(stdout, "\n", { trimempty = true })
          return {
            branch = {
              desc = "Branch to checkout",
              type = "enum",
              choices = branches,
            },
          }
        end,
        builder = function(params)
          return {
            cmd = { "git", "checkout", params.branch },
          }
        end,
        priority = 10,
      })

      require("overseer").register_template({
        name = "dbt build changed",
        params = function()
          local stdout = vim.system({ "git", "diff", "--name-only", "develop", "dbt/models" }):wait().stdout
          local lines = vim.split(stdout, "\n", { trimempty = true })
          local models = {}
          for _, path in ipairs(lines) do
            local parts = {}
            for part in path:gmatch("[^/]+") do
              table.insert(parts, part)
            end

            local fileName = parts[#parts]
            local model = fileName:gsub(".sql", "+")

            table.insert(models, model)
          end
          return {
            models = {
              desc = "Models",
              type = "enum",
              choices = models,
              order = 1,
            },
            fullRefresh = {
              desc = "full refresh?",
              type = "boolean",
              order = 2,
              optional = true,
              default = false,
            },
          }
        end,
        builder = function(params)
          return {
            cmd = { "pipenv" },
            args = {
              "run",
              "dbt",
              "build",
              "-s",
              params.models,
              params.fullRefresh and "-f" or nil,
            },
          }
        end,
        -- Determines sort order when choosing tasks. Lower comes first.
        priority = 15,
        condition = {
          dir = "~/sio/dp/dt",
        },
      })

      require("overseer").register_template({
        name = "dbt build all",
        params = function()
          local stdout = vim.system({ "git", "ls-files", "--directory", "dbt/models" }):wait().stdout
          local lines = vim.split(stdout, "\n", { trimempty = true })
          local models = {}
          for _, path in ipairs(lines) do
            local parts = {}
            for part in path:gmatch("[^/]+") do
              table.insert(parts, part)
            end

            local fileName = parts[#parts]
            local model = fileName:gsub(".sql", "+")

            table.insert(models, model)
          end
          return {
            models = {
              desc = "Models",
              type = "enum",
              choices = models,
              order = 1,
            },
            fullRefresh = {
              desc = "full refresh?",
              type = "boolean",
              order = 2,
              optional = true,
              default = false,
            },
          }
        end,
        builder = function(params)
          return {
            cmd = { "pipenv" },
            args = {
              "run",
              "dbt",
              "build",
              "-s",
              params.models,
              params.fullRefresh and "-f" or nil,
            },
          }
        end,
        -- Determines sort order when choosing tasks. Lower comes first.
        priority = 20,
        condition = {
          dir = "~/sio/dp/dt",
        },
      })

      require("overseer").register_template({
        name = "dbt build custom",
        params = {
          command = {
            type = "string",
            name = "command",
          },
        },
        builder = function(params)
          return {
            cmd = { "pipenv" },
            args = {
              "run",
              "dbt",
              "build",
              "-s",
              params.command,
            },
          }
        end,
        -- Determines sort order when choosing tasks. Lower comes first.
        priority = 25,
        condition = {
          dir = "~/sio/dp/dt",
        },
      })

      require("overseer").register_template({
        name = "sqlfluff lint changed",
        params = function()
          local stdout = vim.system({ "git", "diff", "--name-only", "develop", "dbt/models" }):wait().stdout
          local stripped = stdout:gsub("dbt/models/", "")
          local lines = vim.split(stripped, "\n", { trimempty = true })
          return {
            models = {
              desc = "Models",
              type = "enum",
              choices = lines,
            },
          }
        end,
        builder = function(params)
          return {
            cmd = { "pipenv" },
            args = {
              "run",
              "sqlfluff",
              "lint",
              "dbt/models/" .. params.models,
            },
          }
        end,
        -- Determines sort order when choosing tasks. Lower comes first.
        priority = 30,
        condition = {
          dir = "~/sio/dp/dt",
        },
      })

      require("overseer").register_template({
        name = "sqlfluff lint all",
        params = function()
          local stdout = vim.system({ "git", "ls-files", "--directory", "dbt/models" }):wait().stdout
          local stripped = stdout:gsub("dbt/models/", "")
          local lines = vim.split(stripped, "\n", { trimempty = true })
          return {
            models = {
              desc = "Models",
              type = "enum",
              choices = lines,
            },
          }
        end,
        builder = function(params)
          return {
            cmd = { "pipenv" },
            args = {
              "run",
              "sqlfluff",
              "lint",
              "dbt/models/" .. params.models,
            },
          }
        end,
        -- Determines sort order when choosing tasks. Lower comes first.
        priority = 35,
        condition = {
          dir = "~/sio/dp/dt",
        },
      })
    end,
  },
}
