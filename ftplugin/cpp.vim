" vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=3:ff=unix
function! LaunchApp()
	let s:cmd = FindExeTarget()
	if s:cmd != ""
		execute 'AsyncRun ' . s:cmd
	endif
endfunction
nnoremap <f4> :call LaunchApp()<cr>
if has("gui_win32")
    imap <f5> <esc>:wa<cr>:AsyncRun cmake --build build<cr>:botright copen<cr>:wincmd p<cr>
nnoremap <f4> :call LaunchApp()<cr>
nmap <f5> :wa<cr>:AsyncRun cmake --build build<cr>:botright copen<cr>:wincmd p<cr>
lse
    nnoremap <f4> :exec "Spawn urxvt -e " . FindExeTarget() . " "<left>
    imap <f5> <esc>:wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>
    nmap <f5> :wa<cr>:AsyncRun cmake --build 'build' --target -j8<cr>:botright copen<cr>:wincmd p<cr>
endif

setlocal ts=4 sw=4 noet

setlocal commentstring=//\ %s
" C-style comment using vim-surround
nmap <leader>cc ysiw*gvS/
xmap <leader>cc S*gvS/
" uncoment with ds/

" vim-code-runner settings
let g:code_runner_compiler = 'clang++'
let g:code_runner_standard = 'c++14'
let g:code_runner_flags = ''
let g:code_runner_libs = ''
nmap <F8> :wa<cr>:InteractiveCompile<cr>
nmap <F9> :wa<cr>:DirectCompile<cr>
nmap <F10> :RunCode<cr>

"folding settings
setlocal foldmethod=syntax
setlocal foldnestmax=1
setlocal foldenable
setlocal foldlevel=1

" vim-cmake settings
let g:cmake_build_type = 'Debug'
let g:cmake_custom_vars = '-DRUN_TESTS=Off'
nnoremap <leader>cb :CMake<cr>
nnoremap <leader>cr :CMake -DCMAKE_BUILD_TYPE=Release<cr>
nnoremap <leader>cd :CMake -DCMAKE_BUILD_TYPE=Debug<cr>
nnoremap <leader>cn :CMake -DRUN_TESTS=On<cr>
nnoremap <leader>cf :CMake -DRUN_TESTS=Off<cr>

function! CMakeStat() "{{{
  let s:cmake_build_dir = get(g:, 'cmake_build_dir', 'build')
  let s:build_dir = finddir(s:cmake_build_dir, '.;')

  let s:retstr = ""
  if s:build_dir != ""
      if filereadable(s:build_dir . '/CMakeCache.txt')
          let cmcache = readfile(s:build_dir . '/CMakeCache.txt')
          for line in cmcache
              " cmake variable
              if line =~ "CMAKE_BUILD_TYPE"
                  let value = reverse(split(line, '='))[0]
                  let s:retstr = s:retstr . value . " "
              " custom variable
              elseif line =~ "RUN_TESTS"
                  let value = reverse(split(line, '='))[0]
                  let s:retstr = s:retstr . "T" . value . " "
              endif
          endfor
      endif
  endif
  return substitute(s:retstr, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction"}}}
call airline#parts#define('cmake', {'function': 'CMakeStat'})
let g:airline_section_a = airline#section#create(['branch'])
let g:airline_section_b = airline#section#create(['cmake'])


" mappings for vim-target, vim-testdog, vim-breakgutter
" run test case directly in vim
nnoremap <leader>da :exec "!urxvt -hold -e " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" run test case directly in vim
nnoremap <leader>dc :exec "!" . FindExeTarget() . TestCaseArg()<cr>
" spawn a gdb session in a separate terminal
nnoremap <leader>dg :exec "!urxvt -e gdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestCaseArg() . '&'<cr>
" spawn a gdb session in a separate terminal
nnoremap <leader>dh :exec "!urxvt -e gdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" same but with custom arguments (applies to any app)
nnoremap <leader>dr :exec "!urxvt -e gdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . " " . '&'<left><left>
" run the test case under valgrind
nnoremap <leader>dv :exec "!urxvt -hold -e valgrind --leak-check=full " . FindExeTarget() . TestCaseArg()<cr>
" run the test suite under valgrind
nnoremap <leader>ds :exec "!urxvt -hold -e valgrind --leak-check=full " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" copy the execution line to clipboard
nnoremap <leader>dd :call setreg('+', "gdb " . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestCaseArg())<cr>

let &makeprg="cmake --build 'build' --target"
if !filereadable(".ycm_extra_conf.py")
    call system("ln -s ~/homescripts/.ycm_extra_conf.py .ycm_extra_conf.py")
endif
