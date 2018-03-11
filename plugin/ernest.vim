" Author: Lukas Galke
" Date: 2018-03-11
" Ernest provides a modified insert mode for vim, in which all delete commands are disabled.
"
" Restoring mappings is complicated:
" https://vi.stackexchange.com/questions/7734/how-to-save-and-restore-a-mapping#7735
" For now, we only restore mappings via inoremap without any modifiers.


" The keys to deactivate can be set in advance 
if !exists("g:ernest_evil_keys")
  " Default list of evil keys
  let g:ernest_evil_keys = ['<BS>', '<C-H>', '<Del>', '<C-W>', '<C-U>', '<C-C>', '<C-O>']
endif

" Dictionary to store imap before clearing evil keys
let s:imap_save = {}

function! s:start()
  for key in g:ernest_evil_keys
    " Store previous insert-mode map
    let s:imap_save[key] = maparg(key, 'i')
    " Disable evil keys in insert-mode
    exe "inoremap " . key . ' <nop>'
  endfor
  " Set up hook to revert Ernest imaps
  augroup ernest_hook | au! | au InsertLeave * Ernest! | augroup END
  " Actually enter insert mode
  startinsert!
endfunction

function! s:stop()
  " Remove own InsertLeave hook
  augroup ernest_hook | au! | augroup END
  " Remove <nop> imaps
  for key in g:ernest_evil_keys
    silent! exe "iunmap " . key
  endfor
  " Try to restore original imap
  for [key, value] in items(s:imap_save)
    if !empty(value)
      exe "inoremap " . key . " " . value
    endif
  endfor
  doautocmd User ErnestLeave
  stopinsert
endfunction

command! -bar -bang Ernest if <bang>1 | call <SID>start() | else | call <SID>stop() | endif
