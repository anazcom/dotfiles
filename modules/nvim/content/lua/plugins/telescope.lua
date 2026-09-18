local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local action_state = require("telescope.actions.state")
local code_action = require("tiny-code-action")

-- Toggling preview normally just splits the window in half, which is too
-- cramped to actually read anything. Instead, make the preview take over
-- almost the whole picker (squeezing results down to a thin strip) when
-- shown, and restore the normal split when hidden again.
local function toggle_preview(prompt_bufnr)
	local picker = action_state.get_current_picker(prompt_bufnr)
	local showing_preview = picker.previewer ~= nil
	picker.layout_config = picker.layout_config or {}
	picker.layout_config.preview_width = showing_preview and 0.5 or 0.95
	action_layout.toggle_preview(prompt_bufnr)
end

telescope.setup({
	defaults = {
		path_display = { "truncate", "filename_first" },
		preview = {
			hide_on_startup = true,
		},
		layout_config = {
			-- Default preview_cutoff (120 cols) silently disables the preview
			-- pane on narrower windows, making the <C-p> toggle appear to do
			-- nothing. Lower it so preview always has room when toggled on.
			preview_cutoff = 1,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-p>"] = toggle_preview,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.toggle_selection,
				["<C-a>"] = actions.toggle_all,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-p>"] = toggle_preview,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.toggle_selection,
				["<C-a>"] = actions.toggle_all,
			},
		},
	},
	extensions = {
		frecency = {
			db_safe_mode = false,
			db_validate_threshold = 0,
			show_filter_column = false,
		},
		["ui-select"] = require("telescope.themes").get_dropdown({}),
	},
})

telescope.load_extension("frecency")

code_action.setup({
	picker = {
		"telescope",
		opts = {
			layout_strategy = "horizontal",
		},
	},
})

local function project_root()
	return vim.fs.root(0, { ".git" }) or vim.fs.root(vim.fn.getcwd(), { ".git" }) or vim.fn.getcwd()
end

vim.keymap.set("n", "<leader>ff", function()
    telescope.extensions.frecency.frecency({ cwd = project_root(), workspace = "CWD", hidden = true })
end, { desc = "Find files" })
vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find all config" })
vim.keymap.set("n", "<leader>fg", function()
    builtin.live_grep({ cwd = project_root() })
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search Keymaps" })
