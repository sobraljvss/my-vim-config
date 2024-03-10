"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"GENERAL CONFIGURATIONS------------------------------------------------{{{

set t_ZH=[3m
set t_ZR=[23m

" Disable compatibility with Vi
set nocompatible

" Encoding
set encoding=UTF-8

" Shorter updatetime
set updatetime=300
"
" Signcolumn so diagnostics do not shift text
set signcolumn=yes

" File type detection
filetype on

" Plugins for detected file type
filetype plugin on

" Indent file
filetype indent on

" Syntax highlight
syntax on

" Color scheme
colorscheme onedark

" Relative line enumeration
set relativenumber

" Line highlight
set cursorline

" Column highlight
set cursorcolumn

" Tab width
set shiftwidth=4
set tabstop=4

" Backspace
set bs=2

" Disable line wrap
set nowrap

" Show matching results
set showmatch

" Highlight search results
set incsearch
set hlsearch

" Ignore capital letters on search
set ignorecase

" Search capital letters
set smartcase

" Show partial command
set showcmd

" Show mode
set showmode

" Wild menu configuration
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

	Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-gitgutter'
	Plug 'itchyny/lightline.vim'
	Plug 'mattn/emmet-vim'
	Plug 'terryma/vim-multiple-cursors'
	Plug 'tpope/vim-surround'
	Plug 'w0rp/ale'
	Plug 'prettier/vim-prettier'
	Plug 'neoclide/coc.nvim'
	Plug 'joshdick/onedark.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Normal mode with mm
inoremap mm <esc>

" Centralize
nnoremap n nzz
nnoremap N Nzz

" Autopair brackets and quotes
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ' ''<Left>

" Run Python3 with F5
nnoremap <F5> :!clear <CR> :!python3 %

" Toggle NERDTree with F3
nnoremap <F3> :NERDTreeToggle<cr>

" Tab for completion navigate
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1) :
    \ CheckBackspace() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Enter for completion eleccion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
	\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" Code folding (marker method)

augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal foldmethod=marker
augroup END

" Items ignored by NERDTree
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" ALE configuration
let b:ale_fixers = ['eslint']
let b:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1

" Prettier configuration
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.py PrettierAsync
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'all'

" Snippets configuration
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"


highlight Comment cterm=italic

function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function!  ShowDocumentation()
	if CocAction('hasProvider', 'hover')
		call CocActionAsync('doHover')
	else
		call feedkeys('K', 'in')
	endif
endfunction

" }}}

" STATUS LINE ------------------------------------------------------------ {{{

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

set laststatus=2

" }}}
