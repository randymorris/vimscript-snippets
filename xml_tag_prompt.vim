" Create a mapping in insert mode that will prompt the user for an XML tag
" name then add the open/close pair at the current cursor position leaving the
" cursor in the tag in insert mode.

function! GetTag()
    let tag = input("Tag: ")
    execute "normal! i<".tag."></".tag.">"
    for i in range(strlen(tag)+2)
        normal! h
    endfor
endfunction

inoremap \tag <C-o>:call GetTag()<enter>
