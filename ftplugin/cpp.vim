imap <f5> <esc>:wa<cr>:make! -j8<cr>
nmap <f5> :wa<cr>:make! -j8<cr>
imap <f6> <esc>:wa<cr>:Make! -j8<cr>
nmap <f6> :wa<cr>:Make! -j8<cr>

set ts=4 sw=4 noet
setlocal commentstring=//\ %s

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/
" nnoremap <F9> :SCCompile<cr>
nnoremap <F9> :SCCompileAF --std=c++14 -lboost_system<CR>
nnoremap <F10> :SCCompileRun<cr>

"folding settings
set foldmethod=syntax
set foldnestmax=1      "deepest fold levels
set foldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" mappings for vim-target, vim-testdog, vim-breakgutter
" run test case directly in vim
nnoremap <leader>ds :exec "!" . FindExeTarget() . TestSuiteArg()<cr>
" run test case directly in vim
nnoremap <leader>dc :exec "!" . FindExeTarget() . TestCaseArg()<cr>
" spawn a gdb session in a separate terminal (requires Tim Pope's vim-dispatch plugin)
nnoremap <leader>dg :exec "Spawn urxvt -e gdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestCaseArg()<cr>
" same but with custom arguments (applies to any app)
nnoremap <leader>dr :exec "Spawn urxvt -e gdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . " "<left>
" run the test suite under valgrind
nnoremap <leader>dv :exec "!valgrind --leak-check=full " . FindExeTarget() . TestSuiteArg()<cr>
" copy the execution line to clipboard
nnoremap <leader>dd :call setreg('+', FindExeTarget() . TestCaseArg())<cr>

let &makeprg="cmake --build 'build' --target"
if !filereadable(".ycm_extra_conf.py")
    call system("ln -s ~/homescripts/.ycm_extra_conf.py .ycm_extra_conf.py")
endif
