" Underline the first character of a line that is wrapped.  Similar to how
" showbreak works, but without adding an extra character to the screen.

" Settings combination where this would be useful
set wrap
highlight Underline cterm=underline

augroup showbreak
    autocmd!
    autocmd VimEnter * call <SID>ShowBreakInit()
    autocmd CursorMoved,CursorMovedI,CursorHold * call <SID>ShowBreak()
augroup END

let s:showbreak_matches = []
function! s:ShowBreak()
    " delete old matches
    for l:match in s:showbreak_matches
        silent! call matchdelete(l:match)
    endfor

    let win_width = winwidth("%")
    let line_length = virtcol([line('.'), '$']) - 1
    if line_length > s:showbreak_longest
        let s:showbreak_longest = line_length
    endif

    if s:showbreak_longest > win_width
        " match first column in each wrapped line
        for l:col in range(win_width+1, s:showbreak_longest, win_width)
            call add(s:showbreak_matches, matchadd("Underline", '\%'.l:col.'v'))
        endfor
    endif
endfunction

function s:ShowBreakInit()
    let s:showbreak_longest = max(map(range(1, line('$')), "virtcol([v:val, '$'])-1"))
    call <SID>ShowBreak()
endfunction
