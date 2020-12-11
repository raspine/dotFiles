setlocal commentstring=\%\ %s
imap <f5> <esc>:wa<cr>:AsyncRun octave-cli %<cr>
nmap <f5> :wa<cr>:AsyncRun octave-cli %<cr>
