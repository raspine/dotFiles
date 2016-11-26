imap <c-B> <esc>:wa<cr>:make! -j8<cr>
nmap <c-B> :wa<cr>:make! -j8<cr>
imap <f5> <esc>:wa<cr>:Make! -j8<cr>
nmap <f5> :wa<cr>:Make! -j8<cr>

set ts=4 sw=4 noet

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/
nnoremap <F9> :SCCompileAF --std=c++11 <CR>
noremap <F10> :SCCompileRun<cr>

"folding settings
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=1
