imap <f5> <esc>:wa<cr>:AsyncRun python project/tests<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun python project/tests<cr>:botright copen<cr>:wincmd p<cr>
let &makeprg='python'

"folding settings
set foldmethod=indent
set foldnestmax=2
set foldenable
set foldlevel=1

" run test case directly in vim
nnoremap <leader>ds :wa<cr>:TestSuite<cr>
" run test case directly in vim
nnoremap <leader>dc :wa<cr>:TestNearest<cr>

