" Create user-defined commands that begin with a lowercase letter by running
" the command line through a substitution before executing it. 

" Match/replace pairs used to map the user-command to the vim command
let s:command_line_substitutes = [
    \ ['^ee \(.\+\)', 'e **/\1*'],
    \ ['^ack ', 'Ack! '],
    \ ['^h ', 'vertical help '],
\]

function! s:CommandLineSubstitute()
    let cl = getcmdline()
    if exists('s:command_line_substitutes') && getcmdtype() == ':'
        for [k, v] in s:command_line_substitutes
            if match(cl, k) == 0
                let cl = substitute(cl, k, v, "")
                break
            endif
        endfor
    endif
    return cl
endfunction

cnoremap <enter> <c-\>e<SID>CommandLineSubstitute()<enter><enter>
