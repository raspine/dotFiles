filetype off
" source $VIMRUNTIME/mswin.vim
set noswapfile
set nocompatible
set modelines=0
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
"set relativenumber
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

" white spaces
set list listchars=tab:→\ ,trail:·,precedes:·,nbsp:_
nnoremap <F11> : set list!<CR>
set list!

" mapleader stuff
let mapleader = ","
nnoremap <leader>a :Ack
" reselect pasted text
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
nnoremap <leader>v V`]

cmap w!! w !sudo tee >/dev/null %

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

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
"Plugin 'Lokaltog/vim-easymotion'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'wincent/Command-T.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'szw/vim-ctrlspace'
Plugin '29decibel/codeschool-vim-theme'
Plugin 'jnurmine/Zenburn'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'sudar/vim-arduino-syntax'
" vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" non github repos
" git repos on your local machine (ie. when working on your own plugin)
" Plugin 'file:///Users/gmarik/path/to/plugin'
 " ...
call vundle#end()

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

filetype plugin indent on     " required

map <C-n> :NERDTreeToggle<CR>


set splitright
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <leader>n :vnew<cr>

set tabstop=4
set shiftwidth=4
set softtabstop=4

nnoremap <tab> %
vnoremap <tab> %

noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
nmap mm :update<cr>
"nmap K 5k
"nmap L 5l
nmap ö :
nmap Y y$
nmap å ^

"nmap <Space>h <C-w>h89<C-w>\|
nmap <Space>h <C-w>h
nmap <Space>j <C-w>j
nmap <Space>k <C-w>k
nmap <Space>l <C-w>l
"nmap <Space>l <C-w>l89<C-w>\|
nmap <Space>+ <C-w>_
nmap <Space>0 <C-w>=
nmap <Space>9 91<C-w>\|

"noremap j h
"noremap k j
"noremap l k
"noremap ö l

" session options
set ssop-=options

"folding settings
set foldmethod=syntax
"set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
"set foldlevel=1         "this is just what i use

syntax on

"colorscheme github
"colorscheme mayansmoke
"colorscheme solarized
"set background=light
"colorscheme codeschool
colorscheme zenburn


if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 9
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

" inomq
"set makeprg=make\ -C\ ~/work/arduino/inomq/host/build
"map <f5> :!~/work/arduino/inomq/host/build/inomq_test<cr>
"
" drns
"set makeprg=make\ -C\ ~/work/arduino/drns/host_test/build
"map <f5> :!~/work/arduino/drns/host_test/build/host_test<cr>
"
" tx controller
"set makeprg=make\ -C\ ~/work/receiver/tx_controller/build
"map <f5> :!~/work/receiver/tx_controller/build/tx_controller_test<cr>
"
" nulltick
"set makeprg=make\ -C\ ~/work/receiver/nulltick/build
"map <f5> :!~/work/receiver/nulltick/build/nulltick_test<cr>

" DabPlusFree
set makeprg=make\ -C\ ~/work/audio/dab_encoders/dabplus_free/build
map <f5> :!~/work/audio/dab_encoders/dabplus_free/build/dabplus_free<cr>

nmap <f6> :make<cr>

function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

function! Hardcopy()
  let colors_save = g:colors_name
  colorscheme zellner
  hardcopy
  execute 'colorscheme' colors_save
endfun

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
cd /home/jsc/work
