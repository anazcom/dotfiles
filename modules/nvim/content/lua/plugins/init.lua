vim.pack.add({
	--File Navigation
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-frecency.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },

	--Appareance
	"https://github.com/catppuccin/nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/j-hui/fidget.nvim",

	-- Lsp, completion and formatting
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/b0o/schemastore.nvim",
	"https://github.com/mfussenegger/nvim-jdtls",
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/Saghen/blink.cmp",
    'https://github.com/saghen/blink.lib',
	"https://github.com/rachartier/tiny-code-action.nvim",



	-- Git
	"https://github.com/tpope/vim-fugitive",

	-- Core
	"https://github.com/nvim-lua/plenary.nvim", -- requirement from harpoon
	"https://github.com/nvim-mini/mini.nvim", -- if you use the mini.nvim suite
})

require("plugins.blink")
require("plugins.colorscheme")
require("plugins.diagnostics")
require("plugins.formatter")
require("plugins.git")
require("plugins.harpoon")
require("plugins.lsp")
require("plugins.lualine")
-- require("plugins.oil")
require("plugins.telescope")
