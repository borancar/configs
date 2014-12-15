nnoremap <RightMouse> <LeftMouse>:popup Edit<Enter>

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'wincent/Command-T'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Solarized'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'fugitive.vim'

set background=dark
colorscheme solarized
syntax enable

set showmatch
set showmode
set showcmd
set ruler
set title
set matchtime=2
set textwidth=80
set mouse=a

filetype plugin indent on

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

set guioptions-=m
set guioptions-=T

set nobackup
set noswapfile
set smartcase

set pastetoggle=<F2>

set path=~/**
