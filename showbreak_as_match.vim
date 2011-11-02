" Underline the first character of a line that is wrapped.  Similar to how
" showbreak works, but without adding an extra character to the screen.

hi Underline cterm=underline
augroup showbreak
    autocmd!
    autocmd CursorMovedI * call s:ShowBreak()
augroup END

function! s:ShowBreak()
    let width = winwidth("%") + 1
    if exists('s:showbreak_match')
        call matchdelete(s:showbreak_match)
    endif
    let s:showbreak_match = matchadd("Underline", '\%'.width.'c')
endfunction
