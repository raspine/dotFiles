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
" cursor shape in terminal
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
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
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'nelstrom/vim-visual-star-search'
" Plug 'SirVer/ultisnips'
Plug 'vim-scripts/cd-hook'
Plug 'skywind3000/asyncrun.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'junegunn/fzf.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'yssl/QFEnter'
Plug 'derekwyatt/vim-fswitch'
Plug 'vim-test/vim-test'

" my stuff
Plug 'raspine/vim-target'
Plug 'raspine/vim-testdog', {'branch': 'all_tests'}
" Plug 'raspine/vim-testdog'
Plug 'raspine/vim-breakgutter'
Plug 'raspine/vim-git-project'
Plug 'raspine/vim-code-runner'
Plug 'raspine/vim-xc'

" improved syntax highlightning
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'sirtaj/vim-openscad'

" looks
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'altercation/vim-colors-solarized'
Plug 'kristijanhusak/vim-hybrid-material'

call plug#end()
"}}}

"{{{ plugin config
"{{{ coc
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"}}} coc
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
" let g:UltiSnipsJumpForwardTrigger='<tab>'
" let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" let g:UltiSnipsEditSplit='vertical'
" let g:UltiSnipsSnippetDir=$HOME.'/.vim/UltiSnips'
" " let g:UltiSnipsSnippetDirectories=['UltiSnips']
" let g:UltiSnipsEnableSnipMate=0

" let g:UltiSnipsExpandTrigger = "<nop>"
" let g:ulti_expand_or_jump_res = 0
" function! ExpandSnippetOrCarriageReturn()
"     let snippet = UltiSnips#ExpandSnippetOrJump()
"     if g:ulti_expand_or_jump_res > 0
"         return snippet
"     else
"         return "\<CR>"
"     endif
" endfunction
" inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
"}}}
"{{{ AsyncRun
nmap <F6> :AsyncStop<cr>
" let g:asyncrun_open = 300
"}}}
" {{{ FZF
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
"{{{ vim-test
let test#strategy = "asyncrun"
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
nnoremap <leader>t<space> :tabclose<cr>

" Find symbol of current document
nnoremap <leader>o  :<C-u>CocList outline<cr>
" Find symbol of current workspace
nnoremap <leader>O  :<C-u>CocList -I symbols<cr>

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
nnoremap <leader>ev <C-w><C-v><C-l>:e ~/dotFiles/.vimrc<cr>
nnoremap <leader>eb <C-w><C-v><C-l>:e ~/dotFiles/.bashrc<cr>
nnoremap <leader>es <C-w><C-v><C-l>:e ~/dotFiles/.sshrc<cr>
nnoremap <leader>ea <C-w><C-v><C-l>:e ~/.config/awesome/rc.lua<cr>
nnoremap <leader>eg <C-w><C-v><C-l>:e ~/.gitconfig<cr>
nnoremap <leader>ec <C-w><C-v><C-l>:e ~/.vim/after/ftplugin/cpp.vim<cr>
nnoremap <leader>ex <C-w><C-v><C-l>:e ~/.vim/after/ftplugin/xc.vim<cr>
nnoremap <leader>et <C-w><C-v><C-l>:e ~/.vim/after/ftplugin/typescript.vim<cr>
nnoremap <leader>ep <C-w><C-v><C-l>:e ~/.vim/after/ftplugin/python.vim<cr>
nnoremap <leader>q <esc>:w<cr>:so %<cr>
" open c/c++ companion file
nnoremap <leader>ek :FSSplitAbove<cr>
nnoremap <leader>ej :FSSplitBelow<cr>
nnoremap <leader>eh :FSSplitLeft<cr>
nnoremap <leader>el :FSSplitRight<cr>
nnoremap <leader>ee :FSHere<cr>

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
nnoremap <leader>gv :tab Gvdiffsplit<cr>
nnoremap <leader>gs :tab Ghdiffsplit<cr>
" nnoremap <leader>gi :!eval $(keychain --eval --agents ssh --quiet `find ~/.ssh -type f \( -iname "id_*" ! -iname "*.pub" \)`)<cr>
nnoremap <leader>g<space> :windo diffoff<cr>:q<cr>:Gedit<cr>
nnoremap <leader>gd :Git branch<cr>:call DeleteBranch('')<left><left>
nnoremap <leader>gb :Git branch<cr>:Git checkout<space>
nnoremap <leader>gB :Git branch -a<cr>:Git checkout<space>

" formatting
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" local list
nnoremap <leader>zz :lopen<cr>
nnoremap <leader>z/ :lvim /<c-r>=expand("<cword>")<cr>/ %<cr>:lopen<cr>
nnoremap <leader>z<space> :lclose<cr>

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
    autocmd FileType fugitive nnoremap <buffer> q :q<cr>:wincmd p<cr>
    " autocmd BufWritePre *.cpp :ruby CppAutoInclude::process
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
            call FugitiveDetect(getcwd())
            filetype detect
        endif
    endfor
    " Open other files in split.
    for appFile in l:appFiles
        if !(appFile =~ 'test')
            exec 'sp ' . appFile
            call FugitiveDetect(getcwd())
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
