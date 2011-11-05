" Create a mapping that can be used in insert mode or normal mode to cycle
" through a predetermined list of alternative unicode characters.
"
" Each sublist is a list of characters that will be cycled through when the
" mapping is pressed.  If the same character appears in more than one of these
" lists, bad things will happen.
let g:unicode_list = [
\    [ 'a', 'à', 'â', 'ä' ],
\    [ 'A', 'À', 'Â', 'Ä' ],
\    [ 'e', 'é', 'è', 'ê', 'ë' ],
\    [ 'E', 'É', 'Ê', 'È', 'Ë' ],
\    [ 'i', 'î' ], 
\    [ 'I', 'Î', 'Ï' ],
\    [ 'o', 'ô', 'ö' ],
\    [ 'O', 'Ô', 'Ö' ],
\    [ 'u', 'û', 'ù', 'ü' ],
\    [ 'U', 'Û', 'Ù', 'Ü' ],
\]

function! s:CycleUnicode(mode)
    let char = matchstr(getline('.'), '.', col('.')-1)
    for sublist in g:unicode_list
        let idx = index(sublist, char)
        if idx >= 0
            try
                let char = sublist[idx+1]
            catch /E684/
                let char = sublist[0]
            endtry
            execute "normal! r" . char 
            break
        endif
    endfor
    if a:mode == 'i'
        startinsert
    endif
endfunction

inoremap <f12> <esc>:call <SID>CycleUnicode('i')<enter><right>
nnoremap <f12> :call <SID>CycleUnicode('n')<enter>
