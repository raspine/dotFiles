set ts=2 sts=0 et sw=2 sta

" run node with debug arguments
nnoremap <leader>dr :call DebugNodeApp() <cr>

function! DebugNodeApp()
    let l:breakpoints = FindBreakpoints()
    " insert 'debugger' lines
    for breakpoint in l:breakpoints
        let l:file = split(breakpoint, ':')[0]
        let l:line = split(breakpoint, ':')[1]
        exec "silent! !sed -i '" . l:line . "i debugger' " . l:file
    endfor

    " start node with debugger argument
    " TODO: find the root app file automatically
    exec "!node --inspect-brk main.js"

    " clean up 'debugger' lines
    for breakpoint in l:breakpoints
        let l:file = split(breakpoint, ':')[0]
        let l:line = split(breakpoint, ':')[1]
        exec "silent! !sed -i '" . l:line . "d' " . l:file
    endfor
endfunction

