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
command! CMakeLaunchTarget call s:cmake_launch_target()
command! MyClangFormat call s:cpp_format()

function! s:cpp_format()"{{{
	let s:monorepo_root = system('source /home/jsc/work/monorepo_root.sh && echo -n $MONOREPO_ROOT') . '/'

	let s:file_path = substitute(expand('%:p'), s:monorepo_root, '', '')
	let s:file_name = expand('%:t')
    if s:file_name == "CMakeLists.txt"
		execute  '!cmake-format -i ' .  s:file_path
    else
        lt s:file_path = substitute(expand('%:p'), s:monorepo_root, '', '')
		execute  '!clang-format -i ' .  s:file_path
    endif
endfunction"}}}

" Helper function to find ESP-IDF projects
function! s:find_idf_projects()
    let l:sdkconfig_current = filereadable("./sdkconfig")
    let l:sdkconfig_dirs = []
    
    " Find all sdkconfig files in subdirectories
    let l:find_cmd = "find . -name sdkconfig -type f | sed 's#/sdkconfig##' | sort"
    let l:dirs = systemlist(l:find_cmd)
    
    " Process found directories
    for dir in l:dirs
        " Skip current directory as we'll handle it separately
        if dir != "."
            call add(l:sdkconfig_dirs, dir)
        endif
    endfor
    
    return [l:sdkconfig_current, l:sdkconfig_dirs]
endfunction

" Helper function to select an ESP-IDF project when multiple are found
function! s:select_idf_project(dirs)
    let l:choice_list = ["Select ESP-IDF project directory:"]
    let l:i = 1
    for dir in a:dirs
        call add(l:choice_list, l:i . ". " . dir)
        let l:i += 1
    endfor
    
    " Display menu and get selection
    let l:selection = inputlist(l:choice_list)
    
    " Check if selection is valid
    if l:selection > 0 && l:selection <= len(a:dirs)
        return a:dirs[l:selection-1]
    endif
    
    return ""
endfunction

" Build function
function! s:cmake_build_target()"{{{
    if s:cmake_build_dir == ""
        let s:cmake_build_dir = finddir('build', '.;')
        echom s:cmake_build_dir
    endif

    " Check for ESP-IDF projects
    let [l:sdkconfig_current, l:sdkconfig_dirs] = s:find_idf_projects()
    
    if l:sdkconfig_current
        " Current directory has sdkconfig - build directly
        execute 'AsyncRun idf.py build'
    elseif len(l:sdkconfig_dirs) > 0
        " Multiple sdkconfig files found, present selection menu
        let l:selected_dir = s:select_idf_project(l:sdkconfig_dirs)
        
        if l:selected_dir != ""
            " Run build in the selected directory
            execute 'AsyncRun idf.py -C ' . l:selected_dir . ' build'
        else
            echo "Invalid selection or cancelled."
        endif
    elseif len(s:cmake_build_dir) > 0
        let s:target = FindBuildTarget()
        execute 'AsyncRun ' . 'cmake --build ' . s:cmake_build_dir . ' --target ' . s:target . ' -j16'
    elseif filereadable("./platformio.ini")
        execute 'AsyncRun pio run --target=compiledb && pio run'
    else
        echo "Can't find build dir or sdkconfig files"
    endif
endfunction"}}}

" Launch function for flash and monitor
function! s:cmake_launch_target()"{{{
    " Check for ESP-IDF projects
    let [l:sdkconfig_current, l:sdkconfig_dirs] = s:find_idf_projects()
    
    if l:sdkconfig_current
        " Current directory has sdkconfig - launch directly
        execute 'AsyncRun idf.py flash monitor'
    elseif len(l:sdkconfig_dirs) > 0
        " Multiple sdkconfig files found, present selection menu
        let l:selected_dir = s:select_idf_project(l:sdkconfig_dirs)
        
        if l:selected_dir != ""
            " Flash and monitor in the selected directory
            " execute 'AsyncRun idf.py -C ' . l:selected_dir . ' flash monitor'
			execute 'AsyncRun -mode=term -pos=bottom -rows=20 idf.py -C ' . l:selected_dir . ' -p /dev/ttyACM0 flash monitor'
        else
            echo "Invalid selection or cancelled."
        endif
    elseif filereadable("./platformio.ini")
        execute 'AsyncRun pio run --target=upload && pio device monitor'
    else
        echo "No ESP-IDF projects or PlatformIO project found"
    endif
endfunction"}}}

function! s:cmake_build_all()"{{{
	if s:cmake_build_dir == ""
		let s:cmake_build_dir = finddir('build', '.;')
	endif
    if len(s:cmake_build_dir) == 0
        echom "Can't find build dir"
    else
        execute 'AsyncRun ' . 'cmake --build ' . s:cmake_build_dir . ' -j16'
    endif
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

    if len(s:cmake_build_dir) == 0
        echom "Can't find build dir"
    else
        silent echo system("rm -rf '" . s:cmake_build_dir. "'/*")
        echom "Build directory has been cleaned."
    endif
endfunction"}}}
"}}}

nnoremap <f7> :Launch<space>

" imap <f4> <esc>:wa<cr>:AsyncRun make -j16<cr>:botright copen<cr>:wincmd p<cr>
" nmap <f4> :wa<cr>:AsyncRun make -j16<cr>:botright copen<cr>:wincmd p<cr>
imap <f4> <esc>:wa<cr>:CMakeBuildAll<cr>
nmap <f4> :wa<cr>:CMakeBuildAll<cr>
imap <f5> <esc>:wa<cr>:CMakeBuildTarget<cr>
nmap <f5> :wa<cr>:CMakeBuildTarget<cr>
" nnoremap <f7> :wa<cr>:AsyncRun -mode=term -pos=bottom -rows=20 pio run --target upload && pio device monitor --baud=115200<cr>
" nnoremap <f7> :wa<cr>:AsyncRun -mode=term -pos=bottom -rows=20 idf.py -p /dev/ttyACM0 flash monitor<cr>
nnoremap <f7> :wa<cr>:CMakeLaunchTarget<cr>

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
nnoremap <leader>dd :call setreg('+', "cgdb " . GetGdbBreakpointArgs() . " --args " . FindExeTarget() . TestCaseArg())<cr>

nnoremap <leader>f :MyClangFormat<cr>:e<cr>

