function! s:hlclear()
  if exists('s:m')
    call matchdelete(s:m)
    unlet s:m
  endif
endfunction

function! s:on_change(input)
  call s:hlclear()
  let input = '['. join(map(split(join(a:input, ''), '\zs'), 'printf("\\x%X", char2nr(v:val))'), '][') . ']'
  if len(input) > 0
    let s:m = matchadd("IncSearch", input)
  endif
endfunction

function! s:input(prompt)
  try
    return prompter#input({
    \ 'color': 'Normal',
    \ 'prompt': a:prompt,
    \ 'on_change':  function('s:on_change'),
    \})
  catch
  finally
    call s:hlclear()
  endtry
  return input(a:prompt)
endfunction

function! fixedsearch#search() abort
  call s:hlclear()
  let t = s:input('FIXED: ')
  if t == ''
    redraw!
    return
  endif
  let @/ = '['. join(map(split(t, '\zs'), 'printf("\\x%X", char2nr(v:val))'), '][') . ']'
  call feedkeys('n', 'n')
endfunction
