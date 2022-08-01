require("filetype").setup({
	overrides = {
		extensions = {
			yml = "yaml.ansible",
			yaml = "yaml.cloudformation",
		},
	},
})
