" Create a mapping that can be used in insert mode or normal mode to cycle
" through a predetermined list of alternative unicode characters.
"
" Probably relies on &encoding being set to utf-8 to work properly.
" Borrows function from unicycle.vim (link below).

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
\    [ 'e', 'Î', 'Ï' ],
\    [ 'o', 'ô', 'ö' ],
\    [ 'O', 'Ô', 'Ö' ],
\    [ 'u', 'û', 'ù', 'ü' ],
\    [ 'U', 'Û', 'Ù', 'Ü' ],
\]

function! CycleUnicode(mode)
    let line = getline('.')
    let idx = byteidx(line, virtcol('.')-1)
    let char = UniCycleGetUTF8Char(line, idx)
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

inoremap <f12> <esc>:call CycleUnicode('i')<enter><right>
nnoremap <f12> :call CycleUnicode('n')<enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Source: unicycle.vim 
"         http://www.vim.org/scripts/script.php?script_id=1384
function! UniCycleGetUTF8Char(src, start)
    let nr = char2nr(strpart(a:src, a:start, 1))
    if nr < 128
        let len = 1
    elseif nr < 192
        " Huh? This is not the start of a UTF-8 character!
        let len = 0
    elseif nr < 224
        let len = 2
    elseif nr < 240
        let len = 3
    elseif nr < 248
        let len = 4
    elseif nr < 252
        let len = 5
    else
        let len = 6
    endif
    return strpart(a:src, a:start, len)
endfunction

