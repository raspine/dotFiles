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
set showmatch
set gdefault
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

"{{{ wild mode
set wildmode=list:longest
set wildignorecase
set wildignore=*.o
set wildignore+=**/build-*
set wildignore+=**/*.dir*
"}}}

"{{{ searching
" q/ for search hsitory
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
" set hlsearch
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
Plugin 'ajh17/VimCompletesMe.git'
Plugin 'vhdirk/vim-cmake.git'
Plugin 'jplaut/vim-arduino-ino.git'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'tpope/vim-obsession.git'
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
Plugin 'AndrewRadev/sideways.vim'
Plugin 'ryanss/vim-hackernews'
Plugin 'vim-scripts/cd-hook.git'
Plugin 'artnez/vim-wipeout.git'

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
" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let g:ycm_confirm_extra_conf = 0
" "let g:ycm_key_invoke_completion = '<C-z>'
" let g:EclimCompletionMethod = 'omnifunc'
" let g:enable_ycm_at_startup = 0
"}}}
"{{{ syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list=1
" let g:syntastic_check_on_open=1
" let g:syntastic_check_on_wq=0
" let g:syntastic_cpp_checkers=['clang_check']
" let g:syntastic_cpp_compiler='clang++'
" let g:syntastic_cpp_compiler_options=' -std=c++11 -stdlib=libc++'
" let g:syntastic_cpp_check_header=1
" let g:syntastic_debug=1
"}}}
"{{{ airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#obsession#enabled = 1
" let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
"}}}
"{{{ Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsListSnippets='<c-z>'
let g:UltiSnipsExpandTrigger='<c-x>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
let g:UltiSnipsEditSplit='vertical'
"}}}
"sideways"{{{
nnoremap <c-h> :SidewaysLeft<cr>
nnoremap <c-l> :SidewaysRight<cr>
"}}}
"{{{ cmake
let g:cmake_build_type = 'Debug'
let g:cmake_custom_vars = '-DRUN_TESTS=On'
""}}}
"}}}

"{{{ key mappings
"{{{ general
cmap w!! w !sudo tee >/dev/null %
" join lines and remove the space
nnoremap <silent> <Plug>JoinWithoutSpace $J"_x
\:call repeat#set("\<Plug>JoinWithoutSpace")<CR>
nmap gJ <Plug>JoinWithoutSpace

nnoremap gb :ls<cr>:
vnoremap <tab> %
" type in small letter, convert to capital
imap <C-F> <Esc>gUiw`]a
"}}}
"{{{ mapleader
" quick save
let mapleader = "\\"

map <leader>j %
map <leader>h ^
map <leader>l $

" buffer convenience
nnoremap <leader>bv :vert sfind<space>
nnoremap <leader>bs :sfind<space>
nnoremap <leader>bf :find<space>
nnoremap <leader>bd :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <leader>w :Wipeout<cr>

" paste text from register in command mode
nnoremap <leader>r :reg<CR>:put<space>

" when using many tabs and tabnew..
nnoremap <leader>t :tabs<cr>:tabn

" quickly open ack
nnoremap <leader>a :Ack <c-r>=expand("<cword>")<cr>
" reselect pasted text
nnoremap <leader>v V`]

" config files
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/homescripts/.vimrc<cr>
nnoremap <leader>eb <C-w><C-v><C-l>:e ~/homescripts/.bashrc<cr>
nnoremap <leader>es <C-w><C-v><C-l>:e ~/homescripts/.sshrc<cr>
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.config/awesome/rc.lua<cr>
nnoremap <leader>eg <C-w><C-v><C-l>:e ~/.gitconfig<cr>

" development
nnoremap <leader>cs :call LoadWorkspace()<cr>
nnoremap <leader>cm :CMake<cr>
nnoremap <leader>cr :let g:cmake_build_type='Release'<cr>
nnoremap <leader>cd :let g:cmake_build_type='Debug'<cr>
nnoremap <leader>cn :CMake -DRUN_TESTS=On<cr>
nnoremap <leader>cf :CMake -DRUN_TESTS=Off<cr>

" open copen window
nnoremap <leader>X :botright Copen<cr>
nnoremap <leader>x :botright copen<cr>
nnoremap <leader>cc :cclose<cr>
nnoremap <leader>cl :lclose<cr>

" aid the search and replace command
" TODO: what do \( do?
" :nmap <leader>s :%s/\(<c-r>=expand("<cword>")<cr>\)/
nnoremap <leader>s :%s/<c-r>=expand("<cword>")<cr>/
nnoremap <leader>f :lvim /<c-r>=expand("<cword>")<cr>/ %<cr>:lopen<cr>
nnoremap <leader>g :Gstatus<cr>
nnoremap <leader>d :Gvdiff<cr>
nnoremap <leader>S :so %<cr>
"}}}
" {{{ copy/paste
map Y y$
nmap <c-p> "0p
" nnoremap <silent> <Plug>VisualBlackHolePaste $"_dP
"             \:call repeat#set("\<Plug>VisualBlackHolePaste")<CR>
" xmap p <Plug>VisualBlackHolePaste

xnoremap p "_dP

"system clipboard classic style
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
noremap <C-s> :update<CR>
vnoremap <C-s> <C-C>:update<CR>
inoremap <C-s> <C-O>:update<CR>
"}}}
"{{{ windows handling
map <space> <c-w>
nmap <space>9 91<C-w>\|
nmap <space>n :vnew<cr>

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
    autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> %s/\s\+$//e
    autocmd User chdir :call LoadWorkspace()
augroup END
"}}}

"{{{ colors & font
if has("gui_running")
  " colorscheme hybrid_material
  colorscheme solarized
  set background=light
  if has("gui_gtk3")
    set guifont=Monospace\ 10
  elseif has("gui_win32")
    set guifont=Consolas:h10:cANSI
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

"{{{ scripts
"{{{ LoadWorkspace
function! LoadWorkspace()

    " configure makeprg
    if filereadable("CMakeLists.txt")
        let &makeprg="cmake --build 'build' --target"
    elseif filereadable("configure.ac")
        let &makeprg="make"
    endif

    " reset to vim's standard path setting..
    let &path=".,/usr/include/,,"
    " .. and add our custom ones
    let &path=&path . "," . getcwd() . "/include/**"
    let &path=&path . "," . getcwd() . "/src/**"
    let &path=&path . "," . getcwd() . "/test/**"

    "TODO: use .git to check for submodules path
    if finddir('submodules', -1)=='submodules'
        let &path=&path . "," . getcwd() . "/submodules/**"
    endif

    " the projName is assumed to be the name of the root directory
    let l:projName = reverse(split(getcwd(), '/'))[0]

    " only reset workspace if we find suitable workspace files to open
    " TODO: probably does not work on Windows
    let l:appFiles = glob("`find ./src -maxdepth 1 -name *'".projName."'* -print`")
    if len(appFiles) > 0
        echo appFiles
        " turn off obsession
        if ObsessionStatus() == '[$]'
            exec "Obsession"
        endif

        " delete all buffers
        exec "bufdo bd"

        " open any files that contains projName
        exec "silent! find src/*" . projName . "*.hpp"
        set ft=cpp
        exec "silent! vert sfind src/*" . projName . "*.cpp"
        set ft=cpp
        "TODO: fugitive does not load unless typing :e for each file, why?
        "the below line does not help
        " windo edit
    endif

endfunction
"}}}
"{{{ Test
function! Test()
    " let l:projName = reverse(split(getcwd(), '/'))[0]
    " let l:appFiles = glob("`find ./src -name *'".projName."'* -print`")
    " if len(appFiles) > 0
    "     echo appFiles
    " endif
    let cmcache = readfile("build/CMakeCache.txt")
    for line in cmcache
        if line =~ "CMAKE_BUILD_TYPE"
            let buildType = reverse(split(line, '='))[0]
            echo buildType
            break
        endif
    endfor
endfunction
"}}}
"{{{ Git search TODO:
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
    " Building a hash ensures we get each buffer only once
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(values(buffer_numbers))
endfunction
"}}}
"}}}

if has("gui_win32")
    cd d:\work
else
    cd ~/work
endif


