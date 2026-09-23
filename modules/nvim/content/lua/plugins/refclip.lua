--- Copy the current linewise visual selection as `relative/path:start:end`.
local function copy_visual_line_reference()
	if vim.fn.mode() ~= "V" then
		vim.notify("Select one or more whole lines before copying a file reference", vim.log.levels.ERROR)
		return
	end

	local filename = vim.api.nvim_buf_get_name(0)
	if filename == "" then
		vim.notify("Cannot copy a file reference from an unnamed buffer", vim.log.levels.ERROR)
		return
	end

	local anchor_line = vim.fn.line("v")
	local cursor_line = vim.fn.line(".")
	local start_line = math.min(anchor_line, cursor_line)
	local end_line = math.max(anchor_line, cursor_line)
	local relative_path = vim.fn.fnamemodify(filename, ":.")
	local reference = ("%s:%d:%d"):format(relative_path, start_line, end_line)

	vim.fn.setreg("+", reference)
	vim.notify(("Copied %s"):format(reference), vim.log.levels.INFO)
end

vim.keymap.set("x", "<leader>yr", copy_visual_line_reference, { desc = "[Y]ank File [R]eferences" })
