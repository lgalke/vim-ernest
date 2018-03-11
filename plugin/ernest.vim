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
  let g:ernest_evil_keys = ['<BS>', '<C-H>', '<Del>', '<C-W>', '<C-U>', '<C-C>']
endif

" Dictionary to store imap before clearing evil keys
let s:imap_save = {}

function! s:start()
  " Disable delete commands in insert mode
  " Could use maparg to store previous mappings
  for key in g:ernest_evil_keys
    let s:imap_save[key] = maparg(key, 'i')
    exe "inoremap " . key . ' <nop>'
  endfor
  echo s:imap_save
  " Set up hook to revert Ernest imaps
  augroup ernest_hook
    au!
    " <C-o> triggers InsertLeave
    " <C-c> can, however, sneak around InsertLeave
    au InsertLeave * call <SID>stop()
  augroup END
  startinsert!
endfunction


function! s:stop()
  " Remove own InsertLeave hook
  augroup ernest_hook
    au!
  augroup END
  echo "Ernest hook called"
  " Remove <nop> imaps
  for key in g:ernest_evil_keys
    exe "iunmap " . key
  endfor
  " Try to restore original imap
  for [l:key, l:value] in items(s:imap_save)
    if l:value != ''
      exe "inoremap " . key . " ".value
    endif
  endfor
  stopinsert
  doautocmd User ErnestLeave
endfunction

command! Ernest call <SID>start()
