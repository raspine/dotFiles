imap <f3> <esc>:wa<cr>:AsyncRun xmake clean<cr>:botright copen<cr>:wincmd p<cr>
nmap <f3> :wa<cr>:AsyncRun xmake clean<cr>:botright copen<cr>:wincmd p<cr>
" cmake build
imap <f5> <esc>:wa<cr>:AsyncRun xmake -C build -j8<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun xmake -C build -j8<cr>:botright copen<cr>:wincmd p<cr>
nnoremap <f7> :AsyncRun xrun --id 0 --io app_usb_aud_xk_216_mc/bin/2AMi8o0xxxxxxx/*.xe<cr>:botright copen<cr>:wincmd p<cr>
" xmake build
"imap <f5> <esc>:wa<cr>:AsyncRun xmake CONFIG=Release -j8 2>&1 \| sed -E 's/\.\.\//\.\//g'<cr>:botright copen<cr>:wincmd p<cr>
"nmap <f5> :wa<cr>:AsyncRun xmake CONFIG=Release -j8 2>&1 \| sed -E 's/\.\.\//\.\//g'<cr>:botright copen<cr>:wincmd p<cr>
" nnoremap <f7> :AsyncRun xrun --id 0 --io bin/Release/*.xe<cr>:botright copen<cr>:wincmd p<cr>

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

