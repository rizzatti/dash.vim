" Description: Search Dash.app from vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

"{{{ Creates dummy versions of entry points if Dash.app is not present
function! s:check_for_dash()
  let script = expand('<sfile>:h:h') . '/script/check_for_dash.sh'
  call system(script)
  if v:shell_error " script returns 1 == Dash is present
    return
  endif

  function! s:dummy()
    redraw
    echohl WarningMsg
    echomsg 'dash.vim: Dash.app does not seem to be installed.'
    echohl None
  endfunction

  function! dash#complete(args)
    call s:dummy()
  endfunction

  function! dash#keywords(args)
    call s:dummy()
  endfunction

  function! dash#settings()
    call s:dummy()
  endfunction

  finish
endfunction
"}}}

let s:cache = dash#cache#class.new()

function! dash#complete(arglead, cmdline, cursorpos) "{{{
  return filter(copy(s:cache.keywords()), 'match(v:val, a:arglead) == 0')
endfunction
"}}}

function! dash#keywords(args) "{{{
  let keywords = copy(a:args)
  call filter(keywords, 'index(s:cache.keywords(), v:val) != -1')
  let b:dash_keywords = keywords
endfunction
"}}}

function! dash#settings() "{{{
  redraw
  for profile in s:cache.profiles
    let docsets = join(map(profile.docsets, "v:val.name"), ', ')
    echo 'Profile: ' . profile.name . '; Docsets: ' . docsets
  endfor
  for docset in s:cache.docsets
    echo 'Docset: ' . docset.name . '; Keyword: ' . docset.keyword()
  endfor
endfunction
"}}}














let s:docset_map = {
      \ 'python' : 'python2',
      \ 'java' : 'java7'
      \ }

function! s:extend_docset_map() "{{{
  if !exists('g:dash_map') || type(g:dash_map) != 4
    return
  endif
  call extend(s:docset_map, g:dash_map)
endfunction
"}}}

function! s:get_docset(docset) "{{{
  if !empty(a:docset) && index(s:docsets, a:docset) >= 0
    return a:docset . ':'
  endif
  let position = v:count1 - 1
  let filetypes = split(&filetype, '\.')
  let primary_ft = get(filetypes, -1, '')
  if exists('b:dash_docsets')
    let docset = get(b:dash_docsets, position, primary_ft)
  else
    let docset = get(filetypes, position, primary_ft)
  endif
  let docset = get(s:docset_map, docset, docset)
  return index(s:docsets, docset) == -1 ? '' : docset . ':'
endfunction
"}}}

function! s:search(args, global) "{{{
  let word = get(a:args, 0, expand('<cword>'))
  if a:global
    let docset = ''
  else
    let docset = s:get_docset(get(a:args, 1, ''))
  endif
  silent execute '!open dash://' . docset . word
  redraw!
endfunction
"}}}

function! dash#run(bang, ...) "{{{
  call s:initialize()
  if !s:dash_present
    return
  endif
  call s:search(a:000, a:bang ==# '!' ? 1 : 0)
endfunction
"}}}
