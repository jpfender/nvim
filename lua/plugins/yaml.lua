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
                "!If",
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
