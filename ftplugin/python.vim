imap <f5> <esc>:wa<cr>:AsyncRun docker-compose run test<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun docker-compose run test<cr>:botright copen<cr>:wincmd p<cr>
let &makeprg='python'

"folding settings
set foldmethod=indent
set foldnestmax=2
set foldenable
set foldlevel=0



