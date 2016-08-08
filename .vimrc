" vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=3

"{{{ general
syntax on
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
" disable Ex mode
map q: <nop>
nnoremap Q <nop>
" disable quick quit
map <c-z> <nop>
set autoread
"}}}

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

"{{{ white spaces
set list listchars=tab:→\ ,trail:·,precedes:·,nbsp:_
nnoremap <F11> : set list!<CR>
set list!
"}}}

"{{{ ctags
set tags=./tags;/
"}}}

"{{{ vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

" My Plugins here:
"
" Notes for syntastic
" Install either flake8 or pyulint to make it work
" pacman -S flake8	(for Arch linux)
"
" original repos on github
Plugin 'mileszs/ack.vim'
Plugin 'Valloric/YouCompleteMe.git'
Plugin 'szw/vim-ctrlspace'
Plugin 'szw/vim-g'
Plugin 'vhdirk/vim-cmake.git'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'blindFS/vim-taskwarrior.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'nelstrom/vim-visual-star-search.git'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xuhdev/SingleCompile.git'
Plugin 'sickill/vim-pasta'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'raspine/vim-benD'

" color themes
Plugin 'raspine/Zenburn'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'sheerun/vim-wombat-scheme.git'
Plugin 'kristijanhusak/vim-hybrid-material.git'
call vundle#end()
filetype plugin indent on     " required
"}}}

"{{{ plugin config
"{{{ YCM
" Notes for YCM:
" Sometimes it will crash when building with it own libclang so
" then use:
" pacman -S clang (for Arch linux)
" cd ~/.vim/bundle/YouCompleteMe
" ./install.sh --clang-completer --system-libclang
" ..oh and make sure to add the .ycm_extra_conf.py as specified below
"
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
"let g:ycm_key_invoke_completion = '<C-z>'
let g:EclimCompletionMethod = 'omnifunc'
" let g:enable_ycm_at_startup = 0
"}}}
"{{{ task warrior
" directory to store log files defaults to taskwarrior data.location
let g:task_log_directory   = '~/Dropbox/.task'
"}}}
"{{{ Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsListSnippets='<c-z>'
let g:UltiSnipsExpandTrigger='<c-x>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsEditSplit='vertical'
"}}}
"{{{ vim-g
vmap s :Google<cr>
"}}}
"sideways"{{{
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>
"}}}
"}}}

"{{{ key mappings
"{{{ general
cmap w!! w !sudo tee >/dev/null %
" join lines and remove the space
nnoremap <silent> <Plug>JoinWithoutSpace $J"_x
\:call repeat#set("\<Plug>JoinWithoutSpace")<CR>
nmap gJ <Plug>JoinWithoutSpace

nnoremap gr :reg<CR>
vnoremap <tab> %
map H ^
vnoremap H ^
map L $
vnoremap L $
" type in small letter, convert to capital
map! <C-F> <Esc>gUiw`]a
"}}}
"{{{ mapleader
" quick save
let mapleader = "\\"

map <leader>j %

nnoremap <leader>w :update<cr>
" quickly open ack
nnoremap <leader>a :Ack <c-r>=expand("<cword>")<cr>
" open multiple ctags selection
nnoremap <leader>f g<C-]>
" reselect pasted text
nnoremap <leader>v V`]
" config files
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/homescripts/.vimrc<cr>
nnoremap <leader>eb <C-w><C-v><C-l>:e ~/homescripts/.bashrc<cr>
nnoremap <leader>es <C-w><C-v><C-l>:e ~/homescripts/.sshrc<cr>
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.config/awesome/rc.lua<cr>
nnoremap <leader>eg <C-w><C-v><C-l>:e ~/.gitconfig<cr>
" open copen window
nnoremap <leader>c :botright Copen<cr>
nnoremap <leader>x :botright copen<cr>
nnoremap <leader>z :cclose<cr>
" quickly turn highlight off
nnoremap <leader><space> :noh<cr>
vnoremap <leader><space> :noh<cr>
" aid the search and replace command
" TODO: what do \( do?
" :nmap <leader>s :%s/\(<c-r>=expand("<cword>")<cr>\)/
nnoremap <leader>s :%s/<c-r>=expand("<cword>")<cr>/
nnoremap <leader>g :Gstatus<cr>
nnoremap <leader>d :Gvdiff<cr>
nnoremap <leader>S :so %<cr>
"}}}
" {{{ copy/paste
map Y y$

"system clipboard classic style
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"}}}
"{{{ windows handling
map <space> <c-w>
nmap <space>9 91<C-w>\|
nmap <space>n :vnew<cr>
nmap <space>w <c-w>v
"}}}
"}}}

"{{{ auto commands
augroup MyAutoCommands
    autocmd!
    " source .vimrc when saved
    if has("gui_win32")
        autocmd bufwritepost _vimrc source $MYVIMRC
    else
        autocmd bufwritepost .vimrc source $MYVIMRC
    endif
    autocmd BufNewFile,BufRead *.tid   set ft=markdown
    autocmd BufNewFile,BufRead *.js.tid   set ft=javascript
    autocmd BufNewFile,BufRead *.ino   set ft=c
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
"}}}

"{{{ colors & font
if has("gui_running")
  " colorscheme hybrid_material
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
  colorscheme solarized
  set background=light
  colorscheme zenburn
endif
"}}}

"{{{ printing
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

if has("gui_win32")
    cd d:\work
else
    cd ~/work
endif


