return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!And sequence",
                "!Base64",
                "!Cidr sequence",
                "!Condition",
                "!Equals sequence",
                "!FindInMap sequence",
                "!GetAZs",
                "!GetAtt",
                "!GetAtt sequence",
                "!If sequence",
                "!ImportValue",
                "!Join sequence",
                "!Not sequence",
                "!Or sequence",
                "!Ref",
                "!Select sequence",
                "!Split sequence",
                "!Sub",
                "!Sub sequence",
                "!Transform mapping",
              },
            },
          },
        },
      },
    },
  },
}
