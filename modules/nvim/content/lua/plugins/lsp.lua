require("mason").setup()

local function _next_diagnostic()
	vim.diagnostic.jump({ count = 1 })
end
local function _previous_diagnostic()
	vim.diagnostic.jump({ count = -1 })
end
local function _next_error()
	vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end
local function _previous_error()
	vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.ERROR })
end

--- This is the function that sets up each LSP on attach
---@param client vim.lsp.Client
---@param buf integer
local function on_attach(client, buf)
	local methods = vim.lsp.protocol.Methods

	vim.keymap.set("n", "[d", _previous_diagnostic, { desc = "Previous diagnostic" })
	vim.keymap.set("n", "]d", _next_diagnostic, { desc = "Next diagnostic" })
	vim.keymap.set("n", "[e", _previous_error, { desc = "Previous error" })
	vim.keymap.set("n", "]e", _next_error, { desc = "Next error" })

	if client:supports_method(methods.textDocument_codeAction) then
		-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
				require("tiny-code-action").code_action({
					filter = function(action)
						return not action.disabled
					end,
				})
			end, { desc = "Code Action" })
	end

	if client:supports_method(methods.textDocument_rename) then
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
	end

	if client:supports_method(methods.textDocument_references) then
		vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "List References" })
	end

	if client:supports_method("textDocument/completion") then
		vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
	end
	if client:supports_method("textDocument/implementation") then
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "List Implementation" })
	end
	if client:supports_method(methods.textDocument_definition) then
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
	end
	if client:supports_method(methods.textDocument_signatureHelp) then
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
	end
	if client:supports_method(methods.textDocument_signatureHelp) then
		local triggers = vim.tbl_get(client, "server_capabilities", "signatureHelpProvider", "triggerCharacters") or {}

		vim.api.nvim_create_autocmd("TextChangedI", {
			buffer = buf,
			callback = function()
				local line = vim.api.nvim_get_current_line()
				local col = vim.api.nvim_win_get_cursor(0)[2]
				local char = line:sub(col, col)
				if vim.tbl_contains(triggers, char) then
					vim.lsp.buf.signature_help()
				end
			end,
		})
	end
end


vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("anazcom.LSP", {}),
	callback = function(event)
		local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
		on_attach(client, event.buf)
	end,
})
