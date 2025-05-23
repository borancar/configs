call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-telescope/telescope.nvim'

Plug 'OmniSharp/omnisharp-roslyn'

Plug 'tpope/vim-sleuth'
Plug 'Thyrum/vim-stabs'
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
Plug 'scalameta/nvim-metals'
Plug 'mfussenegger/nvim-dap'
Plug 'LnL7/vim-nix'

Plug 'sebdah/vim-delve'

Plug 'ziglang/zig.vim'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'rebelot/kanagawa.nvim'
call plug#end()

colorscheme kanagawa

" set incremental and smart search
set incsearch
set ignorecase
set smartcase
set nohlsearch

set backupcopy=yes

lua << EOF
vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<C-n>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      end
    end, { "i", "s" }),
    ['<C-p>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require('lspconfig')
lspconfig.gopls.setup {
  capabilities = capabilities,
}
lspconfig.pyright.setup {
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup{
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  capabilities = capabilities,
}
lspconfig.hls.setup {
  capabilites = capabilities,
}
lspconfig.terraformls.setup{
  capabilities = capabilities,
  filetypes = { "terraform", "hcl", "tf", "tfvars" },
}

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  pattern = {"*.tf", "*.tfvars"},
  callback = function()
    vim.lsp.buf.format()
  end,
})

lspconfig.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/usr/bin/mono", "/home/boran/omnisharp/omnisharp/OmniSharp.exe", "--languageserver" },
}
lspconfig.ts_ls.setup {
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}
lspconfig.zls.setup {}

EOF

augroup lsp
  au!
  au FileType scala,sbt,sc lua require("metals").initialize_or_attach({settings = {}})
  au FileType haskell set expandtab shiftwidth=2
  au FileType elm set expandtab shiftwidth=4
augroup end

nnoremap <leader>fu <cmd>Telescope lsp_references<cr>
nnoremap <leader>gd <cmd>Telescope lsp_definitions<cr>
nnoremap <leader>rn <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <leader>dn <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <leader>dN <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <leader>dd <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <leader>dD <cmd>Telescope lsp_workspace_diagnostics<cr>
nnoremap <leader>xx <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>xd <cmd>%Telescope lsp_range_code_actions<cr>

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_ivy({}))<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_ivy({}))<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_ivy({}))<cr>

nnoremap <leader>e <cmd>lua vim.diagnostic.open_float()<cr>

autocmd FileType typescript setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType javascript setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType elm setlocal tabstop=2 shiftwidth=2 expandtab

" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'
