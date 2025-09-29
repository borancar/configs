require("nvchad.configs.lspconfig").defaults()

local servers = {
  "cssls",
  "gopls",
  "html",
  "lua-language-server",
  "rust-analyzer",
  "tofu-ls",
  "typescript-language-server",
}

vim.lsp.config["rust-analyzer"] = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.lock", "Cargo.toml" },
}

vim.lsp.config["tofu-ls"] = {
  cmd = { "tofu-ls", "serve" },
  filetypes = { "terraform", "hcl", "tf", "tfvars", "tofu" },
  root_markers = { ".terraform", "tofu.hcl" },
  settings = {},
}

vim.lsp.config["typescript-language-server"] = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact" },
  settings = {},
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
