nmap <f5> :wa<cr>:make! -j8<cr>
nmap <f6> :wa<cr>:Make! -j8<cr>

set ts=4 sw=4 noet

" https://www.topbug.net/blog/2012/03/07/use-singlecompile-to-compile-and-run-a-single-source-file-easily-in-vim/
noremap <F9> :SCCompile<cr>
noremap <F10> :SCCompileRun<cr>

nmap <F10> :SCCompileAF --std=c++11 <CR>

"folding settings
set foldmethod=syntax
set foldnestmax=1
set foldenable
set foldlevel=1
