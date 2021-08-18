set ts=2 sts=0 et sw=2 sta

nmap <f4> :call InsertDeuggerLines()<cr>:wa<cr>:AsyncRun npm start<cr>
imap <f5> <esc>:wa<cr>:AsyncRun npm run build<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:AsyncRun npm run build<cr>:botright copen<cr>:wincmd p<cr>
nmap <f6> :call ClearDebuggerLines()<cr>:AsyncStop<cr>

function! FindJestTestSuite()
  return expand('%:p')
endfunction

function! FindJestTestCase()
  let l:curr_pos = getpos(".")
  exec "keeppatterns ?test\\_s*("
  let l:new_pos = getpos(".")
  if curr_pos == new_pos
    return ""
  endif
  exec "normal! f'"
  let l:forward_pos = getpos(".")
  let savereg = @a
  exec "normal! \"ayi'"
  if forward_pos == new_pos
    exec "normal! f\""
    exec "normal! \"ayi\""
    forward_pos = getpos(".")
    if forward_pos == new_pos
      let test_case = @a
      return ""
    endif
  endif
  let test_case = @a
  let @a = l:savereg
  :call setpos('.', curr_pos)
  return test_case
endfunction

" run tests via vim-test
nnoremap <leader>dc :exec "AsyncRun node node_modules/.bin/jest --no-coverage -t " . "\"" . FindJestTestCase() . "\""<cr>
nnoremap <leader>da :exec "AsyncRun node node_modules/.bin/jest --no-coverage " . FindJestTestSuite()<cr>
nnoremap <leader>dg :exec "AsyncRun node --inspect-brk node_modules/.bin/jest --runInBand -t " . "\"" . FindJestTestCase() . "\""<cr>


" if !exists("g:ycm_semantic_triggers")
"     let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers['typescript'] = ['.']
" let g:typescript_compiler_options="--experimentalDecorators"

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
