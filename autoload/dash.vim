" Description: Search Dash.app from vim
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let s:initialized = 0

let s:script = expand('<sfile>:h:h') . '/script/check_for_dash.sh'

function! s:check_for_dash() "{{{
  let l:script = s:script
  call system(l:script)
  let s:dash_present = v:shell_error
  if !s:dash_present
    redraw
    echohl WarningMsg
    echomsg 'dash.vim: Dash.app does not seem to be installed.'
    echohl None
  endif
endfunction
"}}}

function! s:create_docsets_cache() "{{{
  let plist = system('defaults read com.kapeli.dash docsets')
  let regex = '\v\{\_.{-}platform \= (\w+);\_.{-}\}'
  let position = 1
  let docsets = []
  while 1
    let matches = matchlist(plist, regex, 0, position)
    if empty(matches)
      break
    endif
    let name = tolower(get(matches, 1))
    if index(docsets, name) == -1
      call add(docsets, name)
    endif
    let position += 1
  endwhile
  call sort(docsets)
  let s:docsets = docsets
endfunction
"}}}

function! s:initialize() "{{{
  call s:check_for_dash()
  call s:create_docsets_cache()
  let s:initialized = 1
endfunction
"}}}

function! s:search(args, global) "{{{
  let l:word = get(a:args, 0, expand('<cword>'))
  if a:global
    let l:ft = ''
  else
    let l:ft = get(split(&filetype, '\.'), 0, '')
    let l:ft = get(a:args, 1, l:ft) . ':'
  endif
  silent execute '!open dash://' . l:ft . l:word
endfunction
"}}}

function! dash#complete(arglead, cmdline, cursorpos) "{{{
  if !s:initialized
    call s:initialize()
  endif
  return filter(copy(s:docsets), 'match(v:val, a:arglead) == 0')
endfunction
"}}}

function! dash#run(bang, ...) "{{{
  if !s:initialized
    call s:initialize()
  endif
  if !s:dash_present
    return
  endif
  call s:search(a:000, a:bang ==# '!' ? 1 : 0)
endfunction
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
