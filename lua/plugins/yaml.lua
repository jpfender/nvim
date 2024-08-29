return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!GetAtt",
                "!Ref",
                "!Sub",
              },
            },
          },
        },
      },
    },
  },
}
