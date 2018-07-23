set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'wincent/command-t'
Plugin 'solarized'
Plugin 'derekwyatt/vim-scala'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'fisadev/vim-isort'
call vundle#end()

set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

filetype plugin indent on

autocmd Filetype python setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype json setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype twig setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4
autocmd Filetype php setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4

set nobackup
set noswapfile
set smartcase

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

let g:vim_isort_python_version='python3'
