" vim: ts=4:sw=4:et:fdm=marker:foldenable:foldlevel=0:fdc=3:ff=unix

"{{{ various scripts
" Launches app (+custom arguments) that file belongs to (using vim-target)
" add a additional 'T' argment to launch app in separate terminal
command! -nargs=? Launch call s:launch(<f-args>)
function! s:launch(...) "{{{
    let l:userArgList = []
	let l:termArgIndex = -1
    if !empty(a:000)
        let l:userArgList = split(a:000[0])
        let l:termArgIndex = index(l:userArgList, "T")
        if l:termArgIndex >= 0
            let l:userArgList = filter(l:userArgList, 'v:val != "T"')
        endif
    endif
	" use vim-target to find the app
	let l:app = silent FindExeTarget()
	if l:app != ""
		if l:termArgIndex >= 0
    		execute "!urxvt -hold -e " . l:app . " " . join(l:userArgList) . '&'
		else
			execute 'AsyncRun ' . l:app . " " . join(l:userArgList)
		endif
	endif
endfunction"}}}

let s:cmake_changed = 0
let s:last_stat_string = ""
let s:cmake_build_dir = ""
"let s:last_target = ""

function! CMakeStat() "{{{
	if s:cmake_changed == 0
		return s:last_stat_string
	endif

	if s:cmake_build_dir == ""
		let s:cmake_build_dir = finddir('build', '.;')
	endif

	let l:retstr = ""
    if filereadable(s:cmake_build_dir . '/CMakeCache.txt')
        let l:cmcache = readfile(s:cmake_build_dir . '/CMakeCache.txt')
        for line in l:cmcache
            " cmake variable
            if line =~ "CMAKE_BUILD_TYPE"
                let l:value = reverse(split(line, '='))[0]
                let l:retstr = l:retstr . l:value . ' '
                " custom variable
            elseif line =~ "RUN_TESTS"
                let l:value = reverse(split(line, '='))[0]
                let l:retstr = l:retstr . "rt:" . l:value . ' '
            elseif line =~ "BUILD_TESTS"
                let l:value = reverse(split(line, '='))[0]
                let l:retstr = l:retstr . "bt:" . l:value . ' '
            elseif line =~ "COVERAGE_INFO"
                let l:value = reverse(split(line, '='))[0]
                let l:retstr = l:retstr . "ci:" . l:value . ' '
            elseif line =~ "CMAKE_CXX_COMPILER:UNINITIALIZED" ||
						\line =~ "CMAKE_CXX_COMPILER_ARG1:STRING"
                let l:value = reverse(split(line, '='))[0]
				let l:value = substitute(l:value, '^\s*\(.\{-}\)\s*$', '\1', '')
                let l:retstr = l:retstr . fnamemodify(l:value, ':t:r') . ' '
            endif
        endfor
    endif
	let s:last_stat_string = substitute(l:retstr, '^\s*\(.\{-}\)\s*$', '\1', '')
	let s:cmake_changed = 0
	return s:last_stat_string
endfunction"}}}

command! -nargs=? CMake call s:cmake(<f-args>)
command! CMakeClean call s:cmakeclean()
command! CMakeBuildAll call s:cmake_build_all()
command! CMakeBuildTarget call s:cmake_build_target()

function! s:cmake_build_target()"{{{
	if s:cmake_build_dir == ""
		let s:cmake_build_dir = finddir('build', '.;')
	endif
    let l:target = fnamemodify(FindExeTarget(), ":t")
    if l:target != ""
        "let s:last_target = fnamemodify(l:target, ":t")
        call setreg("t", l:target)
    else
        let l:target = getreg("t")
    endif
	execute 'AsyncRun ' . 'cmake --build ' . s:cmake_build_dir . ' --target ' . l:target . ' -j16'
endfunction"}}}

function! s:cmake_build_all()"{{{
	if s:cmake_build_dir == ""
		let s:cmake_build_dir = finddir('build', '.;')
	endif
	execute 'AsyncRun ' . 'cmake --build ' . s:cmake_build_dir . ' -j16'
endfunction"}}}

function! s:cmake(...)"{{{
    let s:cmake_build_dir = finddir('build', '.;')
	exec 'cd' s:cmake_build_dir

    " Add default arguments
    let l:argument = []
    let l:argument += [ "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ]

    " Create symbolic link to compilation database for use with YouCompleteMe
    if filereadable("compile_commands.json")
        if has("win32")
            exec "mklink" "../compile_commands.json" "compile_commands.json"
        else
            silent echo system("ln -s " . s:cmake_build_dir . "/compile_commands.json ../compile_commands.json")
        endif
        echom "Created symlink to compilation database"
    endif

    " Execute cmake command
	let s:cmake_changed = 1
	let s:cmd = 'cmake '. join(l:argument, " ") . " " . join(a:000) . ' ..'
    echo s:cmd
    execute 'AsyncRun ' . s:cmd

    exec 'cd - '

endfunction"}}}

function! s:cmakeclean()"{{{
	if s:cmake_build_dir == ""
		let s:cmake_build_dir = finddir('build', '.;')
	endif
    silent echo system("rm -rf '" . s:cmake_build_dir. "'/*")
    echom "Build directory has been cleaned."
endfunction"}}}
"}}}


nnoremap <f7> :Launch<space>

" imap <f4> <esc>:wa<cr>:AsyncRun make -j16<cr>:botright copen<cr>:wincmd p<cr>
" nmap <f4> :wa<cr>:AsyncRun make -j16<cr>:botright copen<cr>:wincmd p<cr>
imap <f4> <esc>:wa<cr>:CMakeBuildAll<cr>:botright copen<cr>:wincmd p<cr>
nmap <f4> :wa<cr>:CMakeBuildAll<cr>:botright copen<cr>:wincmd p<cr>
imap <f5> <esc>:wa<cr>:CMakeBuildTarget<cr>:botright copen<cr>:wincmd p<cr>
nmap <f5> :wa<cr>:CMakeBuildTarget<cr>:botright copen<cr>:wincmd p<cr>

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

" cmake settings
nnoremap <leader>cm :CMake<space>
" for use with CMake command
cabbrev ccg -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++
cabbrev ccc -DCMAKE_C_COMPILER=/usr/bin/clang -DCMAKE_CXX_COMPILER=/usr/bin/clang++
cabbrev cca -DCMAKE_C_COMPILER=/opt/cross-pi-gcc-8.3.0-1/bin/arm-linux-gnueabihf-gcc -DCMAKE_CXX_COMPILER=/opt/cross-pi-gcc-8.3.0-1/bin/arm-linux-gnueabihf-g++
cabbrev cbd -DCMAKE_BUILD_TYPE=Debug
cabbrev cbr -DCMAKE_BUILD_TYPE=Release
cabbrev rto -DRUN_TESTS=On
cabbrev rtf -DRUN_TESTS=Off
cabbrev bto -DBUILD_TESTS=On
cabbrev btf -DBUILD_TESTS=On -DRUN_TESTS=Off
cabbrev cio -DCOVERAGE_INFO=On
cabbrev cif -DCOVERAGE_INFO=Off

call airline#parts#define('cmake', {'function': 'CMakeStat'})
let g:airline_section_a = airline#section#create(['branch'])
let g:airline_section_b = airline#section#create(['cmake'])

" mappings for vim-target, vim-testdog, vim-breakgutter
" run test suite directly in vim
nnoremap <leader>df :exec "AsyncRun " . FindExeTarget() . TestFileArg() . '&'<cr>
" run test suite directly in vim
nnoremap <leader>da :exec "AsyncRun " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" run test case directly in vim
nnoremap <leader>dc :exec "AsyncRun " . FindExeTarget() . TestCaseArg()<cr>
" spawn a gdb session in a separate terminal
nnoremap <leader>dg :exec "!urxvt -e cgdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestCaseArg() . '&'<cr>
" spawn a gdb session in a separate terminal
nnoremap <leader>dh :exec "!urxvt -e cgdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" same but with custom arguments (applies to any app)
nnoremap <leader>dr :exec "!urxvt -e cgdb" . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . " " . '&'<left><left>
" run the test case under valgrind
nnoremap <leader>dv :exec "!urxvt -hold -e valgrind --leak-check=full " . FindExeTarget() . TestCaseArg()<cr>
" run the test suite under valgrind
nnoremap <leader>ds :exec "!urxvt -hold -e valgrind --leak-check=full " . FindExeTarget() . TestSuiteArg() . '&'<cr>
" copy the execution line to clipboard
nnoremap <leader>dd :call setreg('+', "cgdb " . GetGdbBreakpointArgs() . " --args " . FindExeTarget())<cr>

