set nocompatible
set nobackup
set noswapfile

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'wincent/command-t'
Plugin 'solarized'
Plugin 'derekwyatt/vim-scala'
Plugin 'flazz/vim-colorschemes'
Plugin 'fisadev/vim-isort'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'elixir-editors/vim-elixir'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'fatih/vim-go'
call vundle#end()

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" set incremental and smart search
set incsearch
set ignorecase
set smartcase
set nohlsearch

filetype plugin indent on

autocmd Filetype python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype json setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype twig setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype php setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype js setlocal noexpandtab shiftwidth=2 softtabstop=2 tabstop=2

set guioptions-=m
set guioptions-=T

set t_Co=256
set background=dark

if has("gui_running")
    colorscheme C64
    set guifont=Monospace\ 11
endif

set path=~/**
set list
set listchars=tab:>-

let g:CommandTFileScanner = "git"
let g:CommandTGitScanSubmodules = 1
let g:CommandTGitIncludeUntracked = 1

let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
