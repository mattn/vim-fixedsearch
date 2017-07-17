nnoremap <plug>(fixedsearch) :<c-u>call fixedsearch#search()<cr>
if !hasmapto('<plug>(fixedsearch)')
  nmap ,/ <plug>(fixedsearch)
endif
