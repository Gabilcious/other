set nocompatible              " be iMproved, required
filetype off                  " required

" Plugins {{{
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
"Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
"Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-repeat'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'fisadev/vim-isort'
Plugin 'nvie/vim-flake8'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-unimpaired'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" Vimscript file settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
" Basic stuff {{{
syntax on
set modelines=0
set number
set ruler
set visualbell
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c\ %{fugitive#statusline()}
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set undofile
set undodir=~/.vim_runtime/temp_dirs/undodir
set noswapfile
set autoread
set encoding=utf-8
set whichwrap+=<,>,h,l
set lazyredraw
set foldcolumn=1
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:>
set hidden
set ttyfast
set showmode
set showcmd
set autoindent
set smartindent
set wrap
set nolist
set nrformats=
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set diffopt+=vertical
set clipboard=unnamed
nnoremap j gj
nnoremap k gk
map ; :
let mapleader = "\<Space>"
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" }}}
" Whitespace {{{
set textwidth=119
set formatoptions=tcqrn1
set tabstop=4
set shiftwidth=4
set softtabstop=8
set expandtab
set smarttab
set noshiftround
" }}}
" Searching {{{
nnoremap / /\v
vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set gdefault
" }}}
" Color scheme {{{
set background=dark
colorscheme Tomorrow-Night
"
" }}}
" buffers {{{
nmap <leader>l :bnext<CR>
nmap <leader>h :bprevious<CR>
nmap <leader>q :call OpenLast()<CR>

function! OpenLast()
  if bufloaded(bufnr('#'))
    execute "normal! :b# \<BAR> bd #\<CR>"
  else
    execute "normal! :bnext \<BAR> bd #\<CR>"
  endif
endfunction

nmap <leader>bl :ls<CR>
" }}}
" jedi config {{{
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_enabled = 0
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>jg"
let g:jedi#usages_command= "<leader>ju"
" }}}
" other stuff {{{

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" noremap <leader>l :set list!<CR> " Toggle tabs and EOL
" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<CR>:pwd<CR>
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
nnoremap <leader>w <C-w>v<C-w>l
cnoremap w!! w !sudo tee > /dev/null %
" close quickfix window
nnoremap <leader>c :ccl<CR>

" Easy window navigation
noremap <C-H> <C-W>h
noremap <C-K> <C-W>k
noremap <C-J> <C-W>j
noremap <C-L> <C-W>l
inoremap jk <ESC>
inoremap <C-e> <Esc>A
inoremap <C-a> <Esc>I
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
nnoremap ' `
nnoremap ` '
nnoremap Y y$
" Edit the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>
" Clears the search register
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i

noremap x "_x
vnoremap p "_dP

iabbrev pynew # -*- coding: utf-8 -*-<cr># author: Krystian Dowolski (krystian.dowolski@dealavo.com)
iabbrev @@ # author: Krystian Dowolski (krystian.dowolski@dealavo.com)

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]
" }}}
" Ag config {{{
let g:ag_working_path_mode="ra"
nnoremap <leader>a :Ag!<space>
vnoremap <silent> <leader>a :call VisualSelection('gv', '')<CR>
" map <leader>cc :botright cope<cr>
" map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>
" }}}
" Airline config {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
" }}}
" {{{ flake8 config
let g:flake8_show_in_gutter=1
" autocmd BufWritePost *.py call Flake8()
" }}}
" fugitive config {{{
nnoremap <leader>gw :Gwrite!<cr>
nnoremap <leader>gr :Gread<space>
nnoremap <leader>ge :Gedit<space>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gremove<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap gp :diffput <bar> diffupdate
nnoremap go :diffget <bar> diffupdate
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>go :Gbrowse<cr>
vnoremap <leader>go :Gbrowse<cr>

autocmd User fugitive 
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
autocmd BufReadPost fugitive://* set bufhidden=delete

" }}}
" to help learn new macros {{{
inoremap <ESC> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" }}}
" NERDTree config {{{
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>

" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")

" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1

" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1

" Quit on opening files from the tree
let NERDTreeQuitOnOpen=0

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2

" Don't display these kinds of files
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$',
            \ '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

" }}}
" ultisnips config {{{
 " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsListSnippets="lll"
nnoremap <leader>u :UltiSnipsEdit<cr>
"let g:UltiSnipsSnippetDirectories=[".vim/bundle/vim-snippets/UltiSnips"]
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/ultisnips/UltiSnips"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" autopaste {{{
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
" }}}
" functions {{{
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
" }}}




set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

function! SmoothScroll(up)
    if a:up
        let scrollaction=""
    else
        let scrollaction=""
    endif
    exec "normal " . scrollaction
    redraw
    let counter=1
    while counter<&scroll
        let counter+=1
        sleep 10m
        redraw
        exec "normal " . scrollaction
    endwhile
endfunction

nnoremap <C-u> :call SmoothScroll(1)<Enter>
nnoremap <C-d> :call SmoothScroll(0)<Enter>
inoremap <C-U> <Esc>:call SmoothScroll(1)<Enter>i
inoremap <C-D> <Esc>:call SmoothScroll(0)<Enter>i
