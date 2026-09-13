require("catppuccin").setup({
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
	transparent_background = true,
	styles = {
		comments = { "italic" }, -- Change the style of comments
		conditionals = {},
	},
	custom_highlights = function(colors)
		return {
			netrwMarkFile = { fg = colors.yellow, bg = colors.surface1, bold = true },
		}
	end,
})
vim.cmd.colorscheme("catppuccin")
