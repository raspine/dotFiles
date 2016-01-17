filetype off
" source $VIMRUNTIME/mswin.vim
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
"set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set number
set undofile
set guioptions-=T
set printfont=Monospace:h8
set printoptions=number:y

" searching
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
vnoremap <leader><space> :noh<cr>

" line wrapping
set nowrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85
"save on focus lost
au FocusLost * :wa 
" save when switching buffer
set autowrite

" disable Ex mode
map q: <nop>
nnoremap Q <nop>

nnoremap <F2> :cnext<cr>
imap <C-v> <ESC>"+pa

" white spaces
set list listchars=tab:→\ ,trail:·,precedes:·,nbsp:_
nnoremap <F11> : set list!<CR>
set list!

" mapleader stuff
let mapleader = ","
nnoremap <leader>a :Ack 

" reselect pasted text
nnoremap <leader>v V`]
"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" run macro in register q
nnoremap <leader>q @q
" open copen window
nnoremap <leader>c :botright Copen<cr>
nnoremap <leader>x :botright copen<cr>

cmap w!! w !sudo tee >/dev/null %

" ctags stuff
map <leader>g g<C-]>
set tags=./tags;/

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
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'wincent/Command-T.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'sheerun/vim-wombat-scheme.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'szw/vim-ctrlspace'
Plugin '29decibel/codeschool-vim-theme'
Plugin 'raspine/Zenburn'
Plugin 'vhdirk/vim-cmake.git'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'tpope/vim-dispatch.git'
"Plugin 'jaxbot/github-issues.vim.git'
"Plugin 'tpope/vim-unimpaired.git'
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" non github repos
" git repos on your local machine (ie. when working on your own plugin)
" Plugin 'file:///Users/gmarik/path/to/plugin'
 " ...
call vundle#end()
filetype plugin indent on     " required

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:EclimCompletionMethod = 'omnifunc'
"let g:github_access_token = "5cdd43dda506ad92762f94c456c4c0ff37545e97"
let g_gihub_issues_no_omni = 1

map <C-n> :NERDTreeToggle<CR>

set splitright
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>n :vnew<cr>

"nice reading
"http://stackoverflow.com/questions/235839/indent-multiple-lines-quickly-in-vi

nnoremap <tab> %
vnoremap <tab> %

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nmap mm :update<cr>
nmap ö :
nmap Y y$
nmap å ^
noremap ä $

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

" session options
set ssop-=options

"folding settings
set foldmethod=syntax
set foldnestmax=1      "deepest fold levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

syntax on

"colorscheme material-theme
colorscheme solarized
set background=light
"colorscheme zenburn
"colorscheme wombat


if has("gui_running")
  "colorscheme solarized
  "set background=light
  "colorscheme zenburn
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
else
  colorscheme zenburn
endif


function! Hardcopy()
  let colors_save = g:colors_name
  colorscheme zellner
  hardcopy
  execute 'colorscheme' colors_save
endfun

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

