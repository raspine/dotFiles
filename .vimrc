" vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=3
filetype off

set noswapfile
set nocompatible
set modeline
set modelines=5
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set number
set undofile
set guioptions-=T

"{{{ searching
" q/ for search hsitory
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
"}}}

"{{{ line wrapping
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
set splitright
"}}}

" disable Ex mode
map q: <nop>
nnoremap Q <nop>

" {{{ copy/paste good old style
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
"}}}

" white spaces
set list listchars=tab:→\ ,trail:·,precedes:·,nbsp:_
nnoremap <F11> : set list!<CR>
set list!

"{{{ mapleader stuff
let mapleader = ","

noremap <leader>t :NERDTreeToggle<CR>
" quickly open ack
nnoremap <leader>a :Ack 
" open multiple ctags selection
nnoremap <leader>g g<C-]>
" reselect pasted text
nnoremap <leader>v V`]
"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" run macro in register q
nnoremap <leader>q @q
" open copen window
nnoremap <leader>c :botright Copen<cr>
nnoremap <leader>x :botright copen<cr>
" quickly turn highlight off
nnoremap <leader><space> :noh<cr>
vnoremap <leader><space> :noh<cr>
" quickly open new windows
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>n :vnew<cr>

"}}}


" ctags stuff
set tags=./tags;/

"{{{ plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

" My Plugins here:
"
" Notes for YCM:
" Sometimes it will crash when building with it own libclang so
" then use:
" pacman -S clang (for Arch linux)
" cd ~/.vim/bundle/YouCompleteMe
" ./install.sh --clang-completer --system-libclang
" ..oh and make sure to add the .ycm_extra_conf.py as specified below
"
" Notes for syntastic
" Install either flake8 or pyulint to make it work
" pacman -S flake8	(for Arch linux)
"
" original repos on github
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'szw/vim-ctrlspace'
Plugin 'vhdirk/vim-cmake.git'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'blindFS/vim-taskwarrior.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch.git'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nelstrom/vim-visual-star-search.git'
" color themes
Plugin 'raspine/Zenburn'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'sheerun/vim-wombat-scheme.git'
Plugin 'kristijanhusak/vim-hybrid-material.git'
call vundle#end()
filetype plugin indent on     " required
"}}}

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0

" directory to store log files defaults to taskwarrior data.location
 %
let g:task_log_directory   = '~/Dropbox/.task'

let g:airline_theme = "hybrid"


"nice reading
"http://stackoverflow.com/questions/235839/indent-multiple-lines-quickly-in-vi

cmap w!! w !sudo tee >/dev/null %
nmap ` %
vmap ` %
cmap ` %
nmap <tab> $
nmap <s-tab> ^

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nmap mm :update<cr>

nmap Y y$

"{{{ windows handling
nmap <Space>h <C-w>h
nmap <Space>j <C-w>j
nmap <Space>k <C-w>k
nmap <Space>l <C-w>l
nmap <Space>H <C-w>H
nmap <Space>J <C-w>J
nmap <Space>K <C-w>K
nmap <Space>L <C-w>L
nmap <Space>x <C-w>x
nmap <Space>+ <C-w>_
nmap <Space>0 <C-w>=
nmap <Space>9 91<C-w>\|
"}}}

"folding settings
set foldmethod=syntax
set foldnestmax=2      "deepest fold levels
set nofoldenable        "dont fold by default
set foldlevel=2         "this is just what i use

syntax on

"{{{ Colors & font
if has("gui_running")
  colorscheme solarized
  set background=light
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  else
    set guifont=Monospace\ 9
  endif
else
  colorscheme zenburn
endif
"}}}

"{{{ Printing
set printfont=Monospace:h8
set printoptions=number:y
function! Hardcopy()
  let colors_save = g:colors_name
  colorscheme zellner
  hardcopy
  execute 'colorscheme' colors_save
endfun
"}}}

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

cd /home/jsc/work

