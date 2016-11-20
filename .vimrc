set nocompatible
filetype off

"set encoding to utf8"
set encoding=utf-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

execute pathogen#infect()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" The bundles you install will be listed here

filetype plugin indent on

" The rest of your config follows here

 
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'

call vundle#end()            " required
filetype plugin indent on    " required

syntax enable
set background=dark
colorscheme solarized 

set report=0

call togglebg#map("<F5>")
"quicker copy paste and from system
set clipboard=unnamed
set mouse=a

set runtimepath^=~/.vim/bundle/ctrlp.vim



" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

"show a marker when width is over 150  characters"
"match ErrorMsg '\%>150v.\+'




"map nerdtree to f2 button"
map <F2> :NERDTreeToggle<CR>


"showw hidden files in NerdTree
let NERDTreeNowHidden=1

