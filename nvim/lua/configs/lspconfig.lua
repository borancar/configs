require("nvchad.configs.lspconfig").defaults()

local servers = {
  "cssls",
  "gopls",
  "html",
  "lua-language-server",
  "tofu-ls",
  "typescript-language-server",
}

vim.lsp.config["tofu-ls"] = {
  cmd = { "tofu-ls", "serve" },
  filetypes = { "terraform", "hcl", "tf", "tfvars", "tofu" },
  root_markers = { ".git", ".terraform", "tofu.hcl" },
  settings = {},
}

vim.lsp.config["typescript-language-server"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact" },
  settings = {},
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
