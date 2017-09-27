" { Text Objects
call textobj#user#plugin('htmlattribute', {
\   'attribute': {
\     'select-a-function': 'CurrentAttributeA',
\     'select-a': ['ah'],
\     'region-type': 'v',
\     'scan': 'cursor',
\   }
\ })
function! CurrentAttributeA()
  normal! elBh
  let head_pos = getpos('.')
  normal! f{%
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction
call textobj#user#plugin('delimited', {
\   'attribute': {
\     'select-a-function': 'CurrentDelimitedA',
\     'select-a': ['ad'],
\     'region-type': 'v',
\     'scan': 'cursor',
\   }
\ })
function! CurrentDelimitedA()
  normal! ?[{,]l
  let head_pos = getpos('.')
  normal! /[},]h
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction
" }
" }
