" Set 'showbreak' to a string of blank spaces as wide as the current
" numberwidth or the width of the current number column, whichever is greater.

" Settings combination where this would be useful
set number
set wrap
set cpoptions+=n

augroup showbreak
    autocmd!
    autocmd BufRead * call AdjustShowBreak()
augroup END

function! AdjustShowBreak()
    let real_numberwidth = strlen(line('$'))
    let &showbreak = repeat("\ ", max([&nuw, real_numberwidth]))
endfunction
