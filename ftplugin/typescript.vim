set ts=2 sts=0 et sw=2 sta

nmap <f4> :call InsertDeuggerLines()<cr>:wa<cr>:AsyncRun npm start<cr>
imap <f5> <esc>:wa<cr>:AsyncRun tsc<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun tsc<cr>:botright copen<cr>:wincmd p<cr>
nmap <f6> :call ClearDebuggerLines()<cr>:AsyncStop<cr>

if !exists("g:ycm_semantic_triggers")
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
let g:typescript_compiler_options="--experimentalDecorators"

function! InsertDeuggerLines()
    let l:breakpoints = FindBreakpoints()
    for breakpoint in l:breakpoints
        let l:file = split(breakpoint, ':')[0]
        let l:line = split(breakpoint, ':')[1]
        exec "silent! !sed -i '" . l:line . "i debugger' " . l:file
    endfor
endfunction

function! ClearDebuggerLines()
    let l:breakpoints = FindBreakpoints()
    for breakpoint in l:breakpoints
        let l:file = split(breakpoint, ':')[0]
        let l:line = split(breakpoint, ':')[1]
        exec "silent! !sed -i '" . l:line . "d' " . l:file
    endfor
endfunction
