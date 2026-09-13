require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		go = { "goimports", "gofumpt" },
		json = { "prettier" },
		html = { "prettier" },
		angular = { "prettier" },
		java = { "google-java-format" },
	},
})

vim.keymap.set("n", "<leader>fb", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
