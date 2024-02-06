return {
  {
    "PedramNavid/dbtpal",
    config = function()
      local dbt = require("dbtpal")
      dbt.setup({
        -- path_to_dbt = "/Users/jp/.local/share/virtualenvs/dt-dJC1y-XJ/bin/dbt",
        -- path_to_dbt_profiles_dir = "/Users/jp/sio/dbt",
      })
    end,
  },
}
