imap <f5> <esc>:wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>

set ts=4 sw=4 noet
setlocal commentstring=//\ %s

imap <F9> <esc>:wa<cr>:AsyncRun clang++ % -o %:r --std=c++14 -lboost_system<cr>:botright copen<cr>:wincmd p<cr>
nmap <F9> :wa<cr>:AsyncRun clang++ % -o %:r --std=c++14 -lboost_system<cr>:botright copen<cr>:wincmd p<cr>
nmap <F10> :AsyncRun %:r<cr>:botright copen<cr>:wincmd p<cr>

"folding settings
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=1

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
