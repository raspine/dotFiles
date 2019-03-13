if (&ft != 'c')
    finish
endif

if has("gui_win32")
    imap <f5> <esc>:wa<cr>:AsyncRun make<cr>:botright copen<cr>:wincmd p<cr>
    nmap <f5> :wa<cr>:AsyncRun make<cr>:botright copen<cr>:wincmd p<cr>
else
    imap <f5> <esc>:wa<cr>:AsyncRun make -j8<cr>:botright copen<cr>:wincmd p<cr>
    nmap <f5> :wa<cr>:AsyncRun make -j8<cr>:botright copen<cr>:wincmd p<cr>
endif

set ts=4 sw=4 noet

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/

"folding settings
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=1
