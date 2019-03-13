imap <f5> <esc>:wa<cr>:AsyncRun python project/tests<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun python project/tests<cr>:botright copen<cr>:wincmd p<cr>
let &makeprg='python'

"folding settings
set foldmethod=indent
set foldnestmax=1
set foldenable
set foldlevel=0

" vim-test settings
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose' and Python's built-in 'unittest'
let test#python#runner = 'nose'
let test#strategy = "dispatch"

" run test case directly in vim
nnoremap <leader>ds :wa<cr>:TestSuite<cr>
" run test case directly in vim
nnoremap <leader>dc :wa<cr>:TestNearest<cr>

