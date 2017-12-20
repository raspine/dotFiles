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
set guioptions-=M
" disable quick quit
map <c-z> <nop>
" disable ex mode (use gQ for improved ex mode)
nnoremap Q <nop>
set autoread
set nojoinspaces
"}}}

"{{{ wild mode
set wildmode=list:longest
set wildignore=*.o
set wildignore+=**/build-*
set wildignore+=**/*.dir*
set nowildignorecase
set nofileignorecase
"}}}

"{{{ searching
" q/ for search hsitory
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set nohlsearch
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
set tags=./.tags;/
"}}}

"{{{ vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe.git'
Plugin 'mileszs/ack.vim'
Plugin 'vhdirk/vim-cmake.git'
Plugin 'tpope/vim-obsession.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-dispatch.git'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'nelstrom/vim-visual-star-search.git'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'ryanss/vim-hackernews'
Plugin 'vim-scripts/cd-hook.git'
Plugin 'artnez/vim-wipeout.git'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'janko-m/vim-test.git'

" my stuff
Plugin 'raspine/vim-target.git'
Plugin 'raspine/vim-testdog.git'
Plugin 'raspine/vim-breakgutter.git'
Plugin 'raspine/vim-git-project.git'

" improved syntax highlightning
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'pangloss/vim-javascript'

" looks
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized.git'
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
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
" "let g:ycm_key_invoke_completion = '<C-z>'
" let g:EclimCompletionMethod = 'omnifunc'
" let g:enable_ycm_at_startup = 0
"}}}
"{{{ airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 20
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#obsession#enabled = 1
" air-line
if has("gui_running")
    let g:airline_powerline_fonts = 1
else
    let g:airline_powerline_fonts = 0
endif

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif

" " unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" " airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['branch'])
    let g:airline_section_b = airline#section#create_left(['%{CMakeStat()}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

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
"{{{ vim-test
let test#python#runner = 'nose'
let test#strategy = "dispatch"
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose' and Python's built-in 'unittest'
"}}}
"}}}

"{{{ key mappings
"{{{ general
cmap w!! w !sudo tee >/dev/null %
" join lines and remove the space
nnoremap <silent> <Plug>JoinWithoutSpace $J"_x
            \:call repeat#set("\<Plug>JoinWithoutSpace")<CR>
nmap gJ <Plug>JoinWithoutSpace

vnoremap <tab> %
" type in small letter, convert to capital
imap <C-F> <Esc>gUiw`]a
"}}}
"{{{ mapleader
" quick save
let mapleader = "\\"

map <leader>h ^
map <leader>j %
map <leader>k /[A-Z]<CR>
map <leader>l $

" quickly open ack
nnoremap <leader>aa :Ack --ignore-file=is:.tags <c-r>=expand("<cword>")<cr>

" reselect pasted text
nnoremap <leader>x V`]

" when using many tabs and tabnew..
nnoremap <leader>t :tabs<cr>:tabn

" registers
" paste text from register in command mode
nnoremap <leader>rr :reg<CR>:put<space>
" clear registers except q and e
command! WipeReg let regs='123456789abcdfghijklmnoprstuvwxz/-"' | let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | let i=i+1 | endwhile | unlet regs
nnoremap <leader>r<space> :WipeReg<cr>

" buffer convenience
nnoremap <leader>vv :find<space>
nnoremap <leader>vh :vert topleft sfind<space>
nnoremap <leader>vl :vert sfind<space>
nnoremap <leader>vk :sfind<space>
nnoremap <leader>vj :rightbelow sfind<space>
" close buffer and load next buffer into window
nnoremap <leader>vd :bp<bar>sp<bar>bn<bar>bd<CR>
" close all buffers not viewed
nnoremap <leader>v<space> :Wipeout<cr>

" workspace
nnoremap <leader>ww :call InitWorkspace()<cr>
" exit ex mode
cnoremap <leader>w<space> visual<cr>

" config files
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/homescripts/.vimrc<cr>
nnoremap <leader>eb <C-w><C-v><C-l>:e ~/homescripts/.bashrc<cr>
nnoremap <leader>es <C-w><C-v><C-l>:e ~/homescripts/.sshrc<cr>
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.config/awesome/rc.lua<cr>
nnoremap <leader>eg <C-w><C-v><C-l>:e ~/.gitconfig<cr>

" wrap comment word using vim-surround
nmap <leader>cc ysiw*gvS/
" uncoment with ds/

" cmake
nnoremap <leader>cb :CMake<cr>
nnoremap <leader>cr :CMake -DCMAKE_BUILD_TYPE=Release<cr>
nnoremap <leader>cd :CMake -DCMAKE_BUILD_TYPE=Debug<cr>
nnoremap <leader>cn :CMake -DRUN_TESTS=On<cr>
nnoremap <leader>cf :CMake -DRUN_TESTS=Off<cr>

" quickfix
nnoremap <leader>cj :botright copen<cr>
nnoremap <leader>ck :topleft Copen<cr>
nnoremap <leader>c<space> :cclose<cr>

" breakpoints
nnoremap <leader>bb :BreakpointSet<cr>
nnoremap <leader>bc :BreakpointClear<cr>
nnoremap <leader>b<space> :BreakpointClearAll<cr>

" git
nnoremap <leader>gg :Gstatus<cr>
nnoremap <leader>gh :Gvdiff HEAD<cr>
nnoremap <leader>gl :Gvdiff<cr>
" nnoremap <leader>gi :!eval $(keychain --eval --agents ssh --quiet `find ~/.ssh -type f \( -iname "id_*" ! -iname "*.pub" \)`)<cr>
nnoremap <leader>g<space> :windo diffoff<cr>:q<cr>:Gedit<cr>

" local list
nnoremap <leader>ff :lopen<cr>
nnoremap <leader>f/ :lvim /<c-r>=expand("<cword>")<cr>/ %<cr>:lopen<cr>
nnoremap <leader>f. :lvim // %<left><left><left>
nnoremap <leader>f<space> :lclose<cr>

" aid the search and replace command
nnoremap <leader>ss :%s/<c-r>=expand("<cword>")<cr>/
nnoremap <leader>s<space> :windo %s/<c-r>=expand("<cword>")<cr>/

" colors
nnoremap <leader>ns :colorscheme solarized<cr>:set background=light<cr>
nnoremap <leader>nm :colorscheme hybrid_material<cr>:set background=dark<cr>
"}}}
" {{{ copy/paste
map Y y$
" repeatable 'stamping' use equivalent cc instead of S
nnoremap <silent> <Plug>Stamp diw"0P
            \:call repeat#set("\<Plug>Stamp")<CR>
nmap S <Plug>Stamp

" turns 'x' into a blackhole delete operator, use dl/dh instead of 'x'/'X'
" implictly also turns xl/xh to black hole versions of 'x'/'X'
nnoremap xx "_dd
nnoremap x "_d
nnoremap X "_D
vnoremap x "_d

"system clipboard classic style
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p=']
imap <C-v> <C-o>"+P<C-o>=']
cmap <C-v> <C-R>+
"}}}
""{{{ save
noremap <C-s> :call SmartSave()<CR>
vnoremap <C-s> <C-C>:call SmartSave()<CR>
inoremap <C-s> <C-O>:call SmartSave()<CR>
"}}}
"{{{ windows handling
nnoremap <space> <c-w>
nnoremap <space>9 91<C-w>\|
nnoremap <space>n :vnew<cr>

"}}}
"}}}

"{{{ auto commands
augroup MyAutoCommands
    autocmd!
    " source .vimrc when saved
    " if has("gui_win32")
    "     autocmd bufwritepost _vimrc source $MYVIMRC
    " else
    "     autocmd bufwritepost .vimrc source $MYVIMRC
    " endif
    autocmd BufNewFile,BufRead *.tid   set ft=markdown
    autocmd BufNewFile,BufRead *.js.tid   set ft=javascript
    autocmd BufNewFile,BufRead *.ino   set ft=c
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    autocmd FileType c,cpp,java,php,py,js autocmd BufWritePre <buffer> %s/\s\+$//e
    autocmd User chdir :call InitWorkspace()
    " autocmd BufWritePre *.cpp :ruby CppAutoInclude::process
augroup END
"}}}

"{{{ colors & font
if has("gui_running")
    colorscheme solarized
    set background=light
    if has("gui_gtk3") || has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    elseif has("gui_win32")
        set guifont=Consolas:h10:cANSI
    endif
else
    colorscheme desert
endif
"}}}

"{{{ printing
set printfont=Monospace:h8
set printoptions=number:y
"}}}

"{{{ scripts
" TODO: branch completion
command! -nargs=1 DeleteBranch call DeleteBranch(<q-args>)
function! DeleteBranch(branch)
    exec "Git branch -D " . a:branch
    exec "Git push origin :" . a:branch
endfunction
function! InitWorkspace()"{{{
    if !GP_is_repo()
        return
    endif

    " Set vim's 'path' variable. Only directories part of git repo is added.
    " Vim's 'path' will be searched when using the |gf|, [f, ]f, ^Wf, |:find|,
    " |:sfind|, |:tabfind| and other commands.
    let &path='.,' . GP_get_vim_dirs()

    " Create ctags index, exclude directories that are not part of git repo.
    exec 'silent! !ctags -R -f .tags ' . GP_get_ctags_exclude_args()

    " Turn off obsession before delete/opening buffers and avoid messing up
    " current session when change dir to another project.
    if ObsessionStatus() == '[$]'
        exec "Obsession"
    endif

    " Delete all buffers provides a fresh start.
    exec "bufdo bd"

    " Open files containing root name as a default start. This is just a naming
    " convention I use for the main app files in any given project.
    " A ':so Session.vim' loads the last workspace if the main app files is not
    " what I want.
    let appFiles = GP_get_files(GP_get_root_name())

    " Prefer open *test* file first.
    for appFile in l:appFiles
        " open the files that contains projName
        if appFile =~ 'test'
            exec 'e ' . appFile
            call fugitive#detect(getcwd())
            filetype detect
        endif
    endfor
    " Open other files in split.
    for appFile in l:appFiles
        if !(appFile =~ 'test')
            exec 'sp ' . appFile
            call fugitive#detect(getcwd())
            filetype detect
        endif
    endfor

    " Move cursor to bottom file, i.e. the *test* file.
    exec 'silent! 3 wincmd j'
endfunction"}}}
function! SmartSave()"{{{
    if exists(":Gwrite")
        exec "Gwrite"
    else
        exec "update"
    endif

    if filereadable("tags")
        call system('ctags -f .tags -a '. expand("%"))
    endif
endfunction"}}}
function! CMakeStat()"{{{
  let l:cmake_build_dir = get(g:, 'cmake_build_dir', 'build')
  let l:build_dir = finddir(l:cmake_build_dir, '.;')

  let l:retstr = ""
  if l:build_dir != ""
      if filereadable(build_dir . '/CMakeCache.txt')
          let cmcache = readfile(build_dir . '/CMakeCache.txt')
          for line in cmcache
              if line =~ "CMAKE_BUILD_TYPE"
                  let value = reverse(split(line, '='))[0]
                  let retstr = retstr . value . " "
              elseif line =~ "RUN_TESTS"
                  let value = reverse(split(line, '='))[0]
                  let retstr = retstr . "T" . value . " "
              endif
          endfor
      endif
  endif
  " return retstr
  return substitute(retstr, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction"}}}
function! HardCopy()"{{{
  let colors_save = g:colors_name
  colorscheme zellner
  hardcopy
  execute 'colorscheme' colors_save
endfunction"}}}
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
    if getcwd() == '/home/jsc'
        cd ~/work
    endif
endif

