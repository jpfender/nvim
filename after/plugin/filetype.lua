require("filetype").setup({
	overrides = {
		complex = {
			[".*aws/.*yml"] = "yaml.ansible",
			[".*template_.*yaml"] = "yaml.cloudformation",
        },
	},
})
