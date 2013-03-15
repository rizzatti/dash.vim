" Description: Search Dash.app from vim
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:save_cpoptions = &cpoptions
set cpoptions&vim

let s:script = expand('<sfile>:h:h') . '/script/check_for_dash.sh'

function! s:check_for_dash() "{{{
  if exists('s:dash_present')
    return s:dash_present
  endif
  let l:script = s:script
  call system(l:script)
  let s:dash_present = v:shell_error
  return s:dash_present
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

function! dash#run(bang, ...) "{{{
  if !s:check_for_dash()
    redraw
    echohl WarningMsg
    echomsg 'dash.vim: Dash.app does not seem to be installed.'
    echohl None
    return
  endif
  call s:search(a:000, a:bang ==# '!' ? 1 : 0)
endfunction
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
