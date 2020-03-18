" vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=3:ff=unix

"{{{ general
" set nocompatible
set noswapfile
set modeline
set modelines=5
set showmode
set showcmd
set hidden
set showmatch
set cursorline
set ttyfast
set relativenumber
set number
set undofile
set splitright
set encoding=utf-8
set formatoptions=qrn1
set guioptions-=T
set guioptions-=M
" no bells
set noeb vb t_vb=
" disable quick quit
map <c-z> <nop>
" disable ex mode (use gQ for improved ex mode)
nnoremap Q <nop>
set nojoinspaces
set tags +=.tags
"}}}

"{{{ wild mode
set wildmode=list:longest
set nowildignorecase
set nofileignorecase
"}}}

"{{{ searching
" q/ for search history
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set hlsearch
"}}}

"{{{ line wrapping
set nowrap
set textwidth=79
set colorcolumn=85
"}}}

"{{{ plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe.git'
Plugin 'tpope/vim-sensible.git'
Plugin 'tpope/vim-obsession.git'
Plugin 'tpope/vim-characterize.git'
Plugin 'tpope/vim-unimpaired.git'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'nelstrom/vim-visual-star-search.git'
Plugin 'SirVer/ultisnips'
Plugin 'vim-scripts/cd-hook.git'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'janko-m/vim-test.git'
Plugin 'bkad/CamelCaseMotion.git'
Plugin 'junegunn/fzf.vim.git'
Plugin 'dhruvasagar/vim-table-mode.git'
Plugin 'majutsushi/tagbar.git'

" my stuff
Plugin 'raspine/vim-target.git'
Plugin 'raspine/vim-testdog.git'
Plugin 'raspine/vim-breakgutter.git'
Plugin 'raspine/vim-git-project.git'
Plugin 'raspine/vim-code-runner.git'
Plugin 'raspine/vim-xc.git'

" improved syntax highlightning
Plugin 'Matt-Deacalion/vim-systemd-syntax'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim.git'
Plugin 'sirtaj/vim-openscad.git'

" looks
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'kristijanhusak/vim-hybrid-material.git'
call vundle#end()
filetype plugin indent on
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
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" let g:EclimCompletionMethod = 'omnifunc'
" let g:enable_ycm_at_startup = 0
"}}}
"{{{ AirLine
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 20
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#obsession#enabled = 1
let g:airline_theme='hybrid'
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'  " show full tag hierarchy 
" air-line
" if has("gui_running" && !gui_win32)
"     let g:airline_powerline_fonts = 1
" else
"     let g:airline_powerline_fonts = 0
" endif
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

let g:airline_section_a = airline#section#create(['branch'])
let g:airline_section_b = airline#section#create([''])
" function! AirlineInit()
"     let g:airline_section_a = airline#section#create(['branch'])
" endfunction
" autocmd User AirlineAfterInit call AirlineInit()
"}}}
"{{{ Ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger = '<c-x>'
" let g:UltiSnipsListSnippets='<c-z>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetDir=$HOME.'/.vim/UltiSnips'
" let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsEnableSnipMate=0

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
"}}}
"{{{ AsyncRun
nmap <F6> :AsyncStop<cr>
" let g:asyncrun_open = 300
"}}}
" {{{FZF
" Files command with preview window
nnoremap Q: :History:<cr>
nnoremap Q/ :History/<cr>
nnoremap QF :Files<cr>
nnoremap QG :GFiles<cr>
nnoremap QC :BCommits<cr>
nnoremap QL :Lines<cr>
nnoremap QB :Buffers<cr>
nnoremap QT :Tags<cr>
nnoremap QK :Helptags<cr>
command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
command! -bang Colors
  \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)
" [[B]Commits] Customize the options used by 'git log':
" let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --no-ignore-vcs '.shellescape(<q-args>), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
"}}}
"}}}

"{{{ key mappings
"{{{ general
cmap w!! w !sudo tee >/dev/null %
" type in small letter, convert to capital
imap <C-F> <Esc>gUiw`]a
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:.
nnoremap <F11> : set list!<CR>

" use synonym 'yy' instead of 'Y'
map Y y$

" Use synonym 'cc' instead of 'S'. Instead 'S' is used as repeatable 'stamping'.
nnoremap <silent> <Plug>Stamp diw"0P
            \:call repeat#set("\<Plug>Stamp")<CR>
nmap S <Plug>Stamp
" Note: This mapping overrides vim-surround's 'gS'
xmap gS "0P

" Use synonym dl/dh instead of 'x'/'X'. Instead 'x' is used as a camelCase or
" snake_case sensitive version of 'w'.
map <silent> x <Plug>CamelCaseMotion_w
map <silent> X <Plug>CamelCaseMotion_b
sunmap x
sunmap X
omap <silent> ix <Plug>CamelCaseMotion_iw
xmap <silent> ix <Plug>CamelCaseMotion_iw
omap <silent> iX <Plug>CamelCaseMotion_ib
xmap <silent> iX <Plug>CamelCaseMotion_ib
imap <silent> <C-l> <C-o><Plug>CamelCaseMotion_w
imap <silent> <C-h> <C-o><Plug>CamelCaseMotion_b

"system clipboard classic style
vmap <C-c> "+y
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p=']
imap <C-v> <C-o>"+P<C-o>=']
cmap <C-v> <C-R>+
"}}}
"{{{ mapleader
let mapleader = "\\"

map <leader>h ^
map <leader>j %
map <leader>l $

" quickly run Rg command
nnoremap <leader>aa :Rg <c-r>=expand("<cword>")<cr>

" reselect pasted text
nnoremap <leader>x V`]

" when using many tabs and tabnew..
nnoremap <leader>t :tabs<cr>:tabn

" registers
" paste text from register in command mode
nnoremap <leader>rr :reg<CR>:put<space>
" clear registers except e
command! WipeReg let regs='123456789abcdfghijklmnopqrstuvwxz/-"' | let i=0 | while (i<strlen(regs)) | exec 'let @'.regs[i].'=""' | let i=i+1 | endwhile | unlet regs
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
nnoremap <leader>v<space> :call DeleteHiddenBuffers()<cr>

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
nnoremap <leader>ec <C-w><C-v><C-l>:e ~/.vim/ftplugin/cpp.vim<cr>
nnoremap <leader>ex <C-w><C-v><C-l>:e ~/.vim/ftplugin/xc.vim<cr>
nnoremap <leader>ej <C-w><C-v><C-l>:e ~/.vim/ftplugin/javascript.vim<cr>
nnoremap <leader>et <C-w><C-v><C-l>:e ~/.vim/ftplugin/typescript.vim<cr>
nnoremap <leader>ep <C-w><C-v><C-l>:e ~/.vim/ftplugin/python.vim<cr>
nnoremap <leader>q <esc>:w<cr>:so %<cr>

" quickfix
nnoremap <leader>ch :vert topleft copen<cr>
nnoremap <leader>cj :botright copen<cr>
nnoremap <leader>ck :topleft copen<cr>
nnoremap <leader>cl :vert botright copen<cr>
nnoremap <leader>c<space> :cclose<cr>
" <leader>cc reserved for ft plugins
" <leader>cm reserved for ft plugins

" preview
nnoremap <leader>pp :ptag<cr>
nnoremap <leader>p<space> :pclose<cr>

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
nnoremap <leader>gd :Git branch<cr>:call DeleteBranch('')<left><left>
nnoremap <leader>gb :Git branch<cr>:Git checkout<space>
nnoremap <leader>gB :Git branch -a<cr>:Git checkout<space>

" local list
nnoremap <leader>ff :lopen<cr>
nnoremap <leader>f/ :lvim /<c-r>=expand("<cword>")<cr>/ %<cr>:lopen<cr>
nnoremap <leader>f. :lvim // %<left><left><left>
nnoremap <leader>f<space> :lclose<cr>

" aid the search and replace command
nnoremap <leader>ss :%s/\<<c-r>=expand("<cword>")<cr>\>/
nnoremap <leader>s<space> :windo %s/<c-r>=expand("<cword>")<cr>/

" colors
nnoremap <leader>ns :colorscheme solarized<cr>:set background=light<cr>
nnoremap <leader>nm :colorscheme hybrid_material<cr>:set background=dark<cr>
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
    if has("gui_win32")
        autocmd VimEnter * cd d:/work
    else
        autocmd VimEnter * cd ~/work
    endif
    autocmd BufNewFile,BufRead *.tid   set ft=markdown
    autocmd BufNewFile,BufRead *.js.tid   set ft=javascript
    autocmd BufNewFile,BufRead *.ino   set ft=c
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
    autocmd FileType c,cpp,java,php,py,js autocmd BufWritePre <buffer> %s/\s\+$//e
    autocmd User chdir :call InitWorkspace()
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(8, 1)
<<<<<<< HEAD
    autocmd BufEnter COMMIT_EDITMSG startinsert
=======
    autocmd FileType fugitive nnoremap <buffer> q :q<cr>:wincmd p<cr>
    " autocmd BufWritePre *.cpp :ruby CppAutoInclude::process
>>>>>>> f581d83ff88357a92a639db73dffb582a690e7e2
augroup END
"
" for hex editing
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END
"}}}

"{{{ colors & font
if has("gui_running")
    if system('hostname')=~'home'
        colorscheme hybrid_material
        set background=dark
    else
        colorscheme solarized
        set background=light
    endif
    if has("gui_gtk3") || has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    elseif has("gui_win32")
        set guifont=DejaVu_Sans_Mono:h9
        " set guifont=Consolas:h10:cANSI
    endif
endif
"}}}

"{{{ printing
set printfont=Monospace:h8
set printoptions=number:y
"}}}

"{{{ various scripts
"{{{ DeleteBranch TODO: branch completion
command! -nargs=1 DeleteBranch call DeleteBranch(<q-args>)
function! DeleteBranch(branch)
    exec "Git branch -D " . a:branch
    exec "Git push origin :" . a:branch
endfunction "}}}
function! InitWorkspace() "{{{
    if !GP_is_repo()
        echoerr "Not a git repo"
        return
    endif

    " Set vim's 'path' variable. Only directories part of git repo is added.
    " Vim's 'path' will be searched when using the |gf|, [f, ]f, ^Wf, |:find|,
    " |:sfind|, |:tabfind| and other commands.
    let &path='.,' . GP_get_vim_dirs() . 'import/**'

    " Create ctags index, exclude directories that are not part of git repo.
    " exec 'silent! !ctags -R -f .tags ' . GP_get_ctags_exclude_args()
    exec 'silent! !ctags -R -f .tags'

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
endfunction "}}}
function! SmartSave() "{{{
    if exists(":Gwrite")
        exec "Gwrite"
    else
        exec "update"
    endif

    if filereadable(".tags")
        call system('ctags -f .tags -a '. expand("%"))
    endif
endfunction "}}}
function! HardCopy() "{{{
  let colors_save = g:colors_name
  colorscheme zellner
  hardcopy
  execute 'colorscheme' colors_save
endfunction "}}}
"https://stackoverflow.com/questions/8450919/how-can-i-delete-all-hidden-buffers
function! DeleteHiddenBuffers()"{{{
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
"}}}
"}}}
