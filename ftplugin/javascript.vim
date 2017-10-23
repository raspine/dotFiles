
" mappings for vim-target, vim-testdog, vim-breakgutter
"
" run node with debug arguments
nnoremap <leader>dr :exec "Spawn node --inspect-brk main.js"<cr>

function! InsertDebug()
    echo FindBreakpoints()
endfunction

