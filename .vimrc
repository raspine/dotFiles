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
" save when switching buffer
set autowrite

" white spaces
set list listchars=tab:→\ ,trail:·,precedes:·,nbsp:_
nnoremap <F11> : set list!<CR>
set list!

" mapleader stuff
let mapleader = ","
nnoremap <leader>a :Ag 
let g:ag_working_path_mode="r"

" reselect pasted text
nnoremap <leader>v V`]
"open vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>
" run macro in register q
nnoremap <leader>q @q
" open copen window
nnoremap <leader>c :botright copen<cr>

cmap w!! w !sudo tee >/dev/null %

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree.git'
"Plugin 'Lokaltog/vim-easymotion'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'wincent/Command-T.git'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'scrooloose/syntastic.git'
"Plugin 'bling/vim-airline.git'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'szw/vim-ctrlspace'
Plugin 'jnurmine/Zenburn'
Plugin 'rking/ag.vim.git'
Plugin 'vhdirk/vim-cmake.git'

" Plugin 'tpope/vim-rails.git'
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
let g:EclimCompletionMethod = 'omnifunc'

if executable("ag")
	let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif


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

nmap <Space>h <C-w>h
nmap <Space>j <C-w>j
nmap <Space>k <C-w>k
nmap <Space>l <C-w>l
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

"colorscheme solarized
"set background=light
"colorscheme codeschool
colorscheme zenburn


if has("gui_running")
  if has("gui_gtk2")
    set guifont=Monospace\ 10
  elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
  elseif has("gui_win32")
    set guifont=Consolas:h11:cANSI
  endif
endif

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

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>
cd /home/jsc/work

