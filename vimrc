set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set paste
set backupcopy=yes
"set hidden "stop asking to save buffer" 

"add cuda support
autocmd BufNewFile,BufRead *.cu set filetype=cpp

"use C-l to clear search highlighting
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

set visualbell t_vb=
set autoindent
set smartindent
set shiftwidth=2 
set ts=2
set expandtab 


" Press Ctrl-Tab to switch between open tabs (like browser tabs) to 
if has("gui_macvim")
  set guifont=FireCoda:h12
  noremap <C-Tab> :tabnext<CR>
  noremap <C-S-Tab> :tabprev<CR>
  
  " Switch to specific tab numbers with Command-number
  noremap <D-1> :tabn 1<CR>
  noremap <D-2> :tabn 2<CR>
  noremap <D-3> :tabn 3<CR>
  noremap <D-4> :tabn 4<CR>
  noremap <D-5> :tabn 5<CR>
  noremap <D-6> :tabn 6<CR>
  noremap <D-7> :tabn 7<CR>
  noremap <D-8> :tabn 8<CR>
  noremap <D-9> :tabn 9<CR>
  " Command-0 goes to the last tab
  noremap <D-0> :tablast<CR>
endif


set dictionary="/usr/dict/words"
"set spell "Enable Spellcheck by default

set spelllang=en "Set englisch as default check, can be overriden by :setlocal spellang=de

"Define syntax highlight for md and txt files
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.txt set filetype=text

"Spellcheck for md and txt files
autocmd FileType markdown setlocal spell
autocmd FileType text setlocal spell

set autoread
set backspace=indent,eol,start
set complete-=i

set clipboard=unnamed
set showmatch

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

set ruler
set wildmenu

set laststatus=2
set statusline=%f "tail of the filename

" backspace to move backward
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif


" set backup directories
set directory^=$HOME/.vim/swapfiles/

" add space between every character in text 
map <leader>e :'<,'>s/\(.\)/\1 /g<CR>


" persistent undo "
set undodir=~/.vim/undodir
set undofile
set dictionary="/usr/dict/words"


inoremap <C-v> <ESC>"+pa
inoremap <C-c> <ESC>"+y
inoremap <C-d> <ESC>"+d
map <leader>f :FZF<CR>
map <leader>k :ClangFormat<CR>
map <leader>s :update<CR>
map <leader>a :Ack!<space>
map <leader>n :set invnumber<CR>
map <leader>g :NERDTreeToggle<CR>
map <leader>t :!textlint % --fix<CR><CR>
map <leader>p :ALEFix<CR>

"YCM
let g:ycm_auto_trigger = 1 
let g:ycm_global_ycm_extra_conf = '~/ycm_files/.ycm_extra_conf.py'
let g:ycm_python_binary_path = '/usr/local/opt/python'
let g:ycm_cache_omnifunc = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion = 2 
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_use_ultisnips_completer = 1
let g:ycm_cache_omnifunc = 1
let g:ycm_max_diagnostics_to_display=16
let g:ycm_disable_for_files_larger_than_kb = 50000
let g:ycm_key_list_select_completion = ['<C-n>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<C-k>']
let g:ycm_filetype_blacklist = {
			\ 'tagbar' : 1,
			\ 'qf' : 1,
			\ 'notes' : 1,
			\ 'markdown' : 1,
			\ 'unite' : 1,
			\ 'text' : 1,
			\ 'vimwiki' : 1,
			\ 'pandoc' : 1,
			\ 'infolog' : 1,
			\ 'mail' : 1,
			\ 'mundo': 1,
			\ 'fzf': 1,
			\ 'tex': 1,
			\ 'ctrlp' : 1
			\}
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '>*'
let g:ycm_autoclose_preview_window_after_insertion = 1 
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']


let g:python_highlight_all = 1


let g:ale_linters = {
\   'javascript': ['eslint'],
\   'css': ['eslint']
\}

let g:ale_fixers = {
\   'javascript': ['eslint', 'prettier'],
\   'css': ['eslint', 'prettier']
\}

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-tbone'
Plug 'w0rp/ale'
Plug 'vim-python/python-syntax'
Plug 'NLKNguyen/c-syntax.vim'
"Plug 'scrooloose/nerdtree'
Plug 'gabrielelana/vim-markdown'
"Plug 'vim-latex/vim-latex'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
"Plug 'jiangmiao/auto-pairs'
"Plug 'tmsvg/pear-tree'
Plug 'mindriot101/vim-yapf'
Plug 'rhysd/vim-clang-format'
Plug 'davidhalter/jedi-vim'
Plug 'Valloric/YouCompleteMe'
"Plug 'scrooloose/nerdtree'
Plug 'fholgado/minibufexpl.vim'
Plug 'junegunn/fzf'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'mileszs/ack.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'google/vim-searchindex'
"Plug 'maxboisvert/vim-simple-complete'
"Plug 'ajh17/VimCompletesMe'
"Plug 'ervandew/supertab'
"Plug 'ap/vim-buftabline'
"Plug 'reedes/vim-wordy'
Plug 'tpope/vim-sensible'
Plug 'tmux-plugins/vim-tmux'
Plug 'machakann/vim-highlightedyank'
Plug 'sbdchd/neoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"themes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'kaicataldo/material.vim'
Plug 'crusoexia/vim-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'pboettch/vim-highlight-cursor-words'
call plug#end()

let g:dracula_italic = 0
"set background=light
"color gruvbox
"color dracula
"color OceanicNext
"color material
"color solarized8
"color PaperColor
"color delek
"color space-vim-dark
"color apprentice 
