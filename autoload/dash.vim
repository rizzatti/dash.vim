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
  let script = s:script
  call system(script)
  let s:dash_present = v:shell_error
  return s:dash_present
endfunction
"}}}

function! s:search(word, global) "{{{
  let filetype = ''
  if !a:global
    let filetype = &filetype . ':'
  endif
  silent execute '!open dash://' . filetype . a:word
endfunction
"}}}

function! dash#run(word, bang) "{{{
  if !s:check_for_dash()
    redraw
    echohl WarningMsg
    echomsg 'dash.vim: Dash.app does not seem to be installed.'
    echohl None
    return
  endif
  call s:search(a:word, a:bang ==# '!' ? 1 : 0)
endfunction
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
