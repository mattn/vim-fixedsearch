function! fixedsearch#search() abort
  let t = input('FIXED: ')
  if t == ''
    redraw!
    return
  endif
  let @/ = '['. join(map(split(t, '\zs'), 'printf("\\x%X", char2nr(v:val))'), '][') . ']'
  call feedkeys('n', 'n')
endfunction
