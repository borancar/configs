require("nvchad.configs.lspconfig").defaults()

local servers = {
  "cssls",
  "gopls",
  "html",
  "lua-language-server",
  "typescript-language-server",
}
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
