imap <f5> <esc>:wa<cr>:make! -j8<cr>
nmap <f5> :wa<cr>:make! -j8<cr>
imap <f6> <esc>:wa<cr>:Make! -j8<cr>
nmap <f6> :wa<cr>:Make! -j8<cr>

set ts=4 sw=4 noet
setlocal commentstring=//\ %s

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/
" nnoremap <F9> :SCCompile<cr>
nnoremap <F9> :SCCompileAF --std=c++11 <CR>
nnoremap <F10> :SCCompileRun<cr>

"folding settings
set foldmethod=syntax
set foldnestmax=1      "deepest fold levels
set foldenable        "dont fold by default
set foldlevel=1         "this is just what i use
