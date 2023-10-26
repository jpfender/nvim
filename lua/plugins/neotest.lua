return {
  {
    "neotest",
    opts = function(_, opts)
      opts.adapters = vim.tbl_extend("force", opts.adapters, {
        ["neotest-python"] = {
          dap = { justMyCode = false },
          args = { "--log-level", "DEBUG" },
          runner = "pytest",
          python = function()
            return vim.fn.getenv("VIRTUAL_ENV") .. "/bin/python"
          end,
        },
      })
    end,
  },
}
