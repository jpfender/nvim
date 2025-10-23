-- disable
if true then
  return {}
end
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        yamlls = {
          settings = {
            yaml = {
              customTags = {
                "!Equals",
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
