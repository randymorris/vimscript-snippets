" Show how plugins should make configurable mappings such that existing
" mappings do not get overridden.

function! s:ExampleFunction()
    echomsg "ExampleFunction called successfully."
endfunction

function! s:OtherFunction()
    echomsg "OtherFunction called successfully."
endfunction

" Always provide a way to disable creating default mappings
if exists('g:plugin_name_prevent_mappings') && g:plugin_name_prevent_mappings
    finish
endif

" Set up configurable mappings
nnoremap <plug>CallExampleFunction :call <sid>ExampleFunction()<cr>
nnoremap <plug>CallOtherFunction :call <sid>OtherFunction()<cr>
 
" Attempt to create mappings.
"  - Use '<unique>' to thow an error if the user already has a conflicting
"    mapping.
"  - Use 'silent!' to hide these errors and just not perform the mapping.

"  - Non-filetype specific plugin mapping should use <leader>
if !hasmapto('<plug>CallExampleFunction')
    silent! nmap <unique> <leader>e <plug>CallExampleFunction
endif

"  - Filetype specific plugin mappings should use <localleader>
if !hasmapto('<plug>CallExampleFunction2')
    silent! nmap <unique> <localleader>o <plug>CallOtherFunction
endif
