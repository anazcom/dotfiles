return {
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = vim.tbl_extend("force", require("schemastore").yaml.schemas(), {
				["https://www.schemastore.org/github-action.json"] = {
					".github/actions/**/action.yml",
					".github/actions/**/action.yaml",
				},
			}),
		},
	},
}
