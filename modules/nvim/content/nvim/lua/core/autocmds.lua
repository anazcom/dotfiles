-- Force checking for external file changes so autoread actually triggers
-- (requires tmux's `focus-events on` so FocusGained reaches nvim)
vim.api.nvim_create_autocmd("FocusGained", {
	group = vim.api.nvim_create_augroup("checktime_reload", { clear = true }),
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Notify when a buffer is auto-reloaded due to external changes
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = vim.api.nvim_create_augroup("checktime_notify", { clear = true }),
	callback = function()
		vim.notify("File changed on disk, buffer reloaded", vim.log.levels.INFO)
	end,
})

vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("pascal_ft", { clear = true }),
	pattern = { "*.eds" },
	callback = function()
		vim.bo.filetype = "pascal"
	end,
})

-- syntax highlighting for dotenv files
vim.api.nvim_create_autocmd("BufRead", {
	group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
	pattern = { ".env", ".env.*" },
	callback = function()
		vim.bo.filetype = "dosini"
	end,
})

-- remove plugins from disk that are no longer in vim.pack.add() specs
vim.api.nvim_create_user_command("PackClean", function()
	local inactive = vim.iter(vim.pack.get())
		:filter(function(x)
			return not x.active
		end)
		:map(function(x)
			return x.spec.name
		end)
		:totable()
	if #inactive == 0 then
		vim.notify("No inactive plugins to remove", vim.log.levels.INFO)
		return
	end
	vim.pack.del(inactive)
	vim.notify("Removed: " .. table.concat(inactive, ", "), vim.log.levels.INFO)
end, { desc = "Remove plugins not in vim.pack.add() specs" })
