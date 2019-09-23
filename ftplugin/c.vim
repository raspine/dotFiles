if (&ft != 'c')
    finish
endif

imap <f4> <esc>:wa<cr>:AsyncRun make -j8<cr>:botright copen<cr>:wincmd p<cr>
nmap <f4> :wa<cr>:AsyncRun make -j8<cr>:botright copen<cr>:wincmd p<cr>
imap <f5> <esc>:wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>

set ts=4 sw=4 noet
setlocal commentstring=/*%s*/

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/

"folding settings
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=1
