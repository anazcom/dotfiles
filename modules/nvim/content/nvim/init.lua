require("core")
require("plugins")

vim.lsp.enable("lua_ls")
vim.lsp.enable("clangd", false)
vim.lsp.enable("gopls", false)
vim.lsp.enable("jsonls", true)
vim.lsp.enable("yaml-language-server", false)
-- jdtls is started per-buffer by nvim-jdtls, see ftplugin/java.lua
vim.lsp.enable("jdtls", false)
vim.lsp.enable("lemminx", true)
vim.lsp.enable("angular-language-server", false)
