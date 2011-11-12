" This is intended to be used in lieu of 'hlsearch'.  Flash the location of
" the next occurrence when searching or jumping using 'n' or 'N'.
" TODO: preserve existing cmap on <cr>

" Settings where this would be useful
set nohlsearch
let s:flash_group = 'Error'
let s:flash_timeout = 150

function! s:FlashNext()
    let param = getreg('/')
    let pos = getpos('.')
    let next_match = matchadd(s:flash_group, '\%'.pos[1].'l\%'.pos[2].'v'.param)
    redraw
    execute "sleep ".s:flash_timeout."ms"
    silent! call matchdelete(next_match)
endfunction

function! s:FlashMatch()
    let cmd_type = getcmdtype()
    if cmd_type == '/' || cmd_type == '?'
        return "\<cr>:call ".s:SID()."FlashNext()\<cr>"
    endif
    return "\<cr>"
endfunction

function! s:SID()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID$')
endfun

nnoremap <silent> n n:call <sid>FlashNext()<enter>
nnoremap <silent> N N:call <sid>FlashNext()<enter>
cnoremap <silent> <expr> <enter> <sid>FlashMatch()
