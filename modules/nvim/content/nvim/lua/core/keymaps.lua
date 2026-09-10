-- Keymaps

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Movements
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Line one line to bottom" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Line one line to top" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Ocurrence in Middle Screen" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous Ocurrence in Middle Screen" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down Keeping Cursor in the Middle" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up Keeping Cursor in the Middle" })

-- Yanks
vim.keymap.set({ "v", "n" }, "Y", "y$", { desc = "Yank to the end of file" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]], { desc = "Paste from system clipboard" })


-- -- Completion navigation
-- vim.keymap.set("i", "<C-Space>", vim.lsp.completion.get, { desc = "Trigger completion" })
-- vim.keymap.set("i", "<C-j>", function()
-- 	return vim.fn.pumvisible() == 1 and "<C-n>" or "<C-j>"
-- end, { expr = true, desc = "Next completion item" })
-- vim.keymap.set("i", "<C-k>", function()
-- 	return vim.fn.pumvisible() == 1 and "<C-p>" or "<C-k>"
-- end, { expr = true, desc = "Previous completion item" })
