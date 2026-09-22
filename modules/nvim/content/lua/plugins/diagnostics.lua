-- cmdheight = 0 causes floating-window/cursor redraw corruption over
-- higher-latency connections (e.g. SSH into a devcontainer), so keep the
-- default single-line cmdline instead.
vim.diagnostic.config({
	underline = true,
	virtual_text = false,
	update_in_insert = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
})


vim.keymap.set("n", "<leader><leader>", vim.diagnostic.open_float, { desc = "Open Diagnostics" })

require("tiny-inline-diagnostic").setup({
	preset = "simple",
	transparent_cursorline = false,
	options = {
		multilines = {
			enabled = true,
		},
	},
})

local fidget = require("fidget")
fidget.setup({})
