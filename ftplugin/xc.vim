imap <f4> <esc>:wa<cr>:AsyncRun xmake clean<cr>:botright copen<cr>:wincmd p<cr>
nmap <f4> :wa<cr>:AsyncRun xmake clean<cr>:botright copen<cr>:wincmd p<cr>
imap <f5> <esc>:wa<cr>:AsyncRun xmake CONFIG=Release<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun xmake CONFIG=Release<cr>:botright copen<cr>:wincmd p<cr>
nnoremap <f7> :AsyncRun xrun --id 0 --io ../bin/Release/*.xe<cr>:botright copen<cr>:wincmd p<cr>

setlocal ts=4 sw=4 noet

setlocal commentstring=//\ %s
" C-style comment using vim-surround
nmap <leader>cc ysiw*gvS/
xmap <leader>cc S*gvS/
" uncoment with ds/

setlocal foldmethod=syntax
setlocal foldnestmax=1
setlocal foldenable
setlocal foldlevel=1

