return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.picker = {
        matcher = {
          frecency = true,
        },
        transform = function(item)
          local filename = vim.fn.fnamemodify(item.file, ":t")
          if filename and filename:match("^test_") then
            item.score_add = (item.score_add or 0) - 30
          end
        end,
      }
    end,
  },
}
