" Description: Search Dash.app from Vim
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

  function! dash#complete(...)
    call s:dummy()
  endfunction

  function! dash#keywords(...)
    call s:dummy()
  endfunction

  function! dash#search(...)
    call s:dummy()
  endfunction

  function! dash#settings(...)
    call s:dummy()
  endfunction

  finish
endfunction
"}}}

let s:cache = dash#cache#class.new()

let s:keywords_map = {
      \ 'python' : 'python2',
      \ 'java' : 'java7'
      \ }

function! dash#complete(arglead, cmdline, cursorpos) "{{{
  return filter(copy(s:cache.keywords()), 'match(v:val, a:arglead) == 0')
endfunction
"}}}

function! dash#keywords(...) "{{{
  let keywords = copy(a:000)
  call filter(keywords, 'index(s:cache.keywords(), v:val) != -1')
  let b:dash_keywords = keywords
endfunction
"}}}

function! dash#search(bang, ...) "{{{
  let term = get(a:000, 0, expand('<cword>'))
  if !empty(a:bang) " global search
    call s:search(term, '')
    return
  endif
  let keyword = get(a:000, 1, '')
  if !empty(keyword) " keyword given
    let keyword = index(s:cache.keywords(), keyword) != -1 ? keyword : ''
    call s:search(term, keyword)
    return
  endif
  let position = v:count1 - 1
  let filetype = get(split(&filetype, '\.'), -1, '')
  if exists('b:dash_keywords')
    let keyword = get(b:dash_keywords, position, filetype)
  else
    let keyword = get(s:keywords_map, filetype, filetype)
  endif
  let keyword = index(s:cache.keywords(), keyword) != -1 ? keyword : ''
  call s:search(term, keyword)
endfunction
"}}}

function! dash#settings() "{{{
  redraw
  for profile in s:cache.profiles
    let docsets = join(map(copy(profile.docsets), "v:val.name"), ', ')
    echo 'Profile: ' . profile.name . '; Keyword: ' . profile.keyword .
          \ '; Docsets: ' . docsets
  endfor
  for docset in s:cache.docsets
    echo 'Docset: ' . docset.name . '; Keyword: ' . docset.keyword()
  endfor
endfunction
"}}}

function! s:extend_keywords_map() "{{{
  if !exists('g:dash_map') || type(g:dash_map) != 4
    return
  endif
  call extend(s:keywords_map, g:dash_map)
endfunction
"}}}

function! s:search(term, keyword) "{{{
  let keyword = a:keyword
  if !empty(keyword)
    let keyword = keyword . ':'
  endif
  silent execute '!open dash://' . keyword . a:term
  redraw!
endfunction
"}}}

call s:extend_keywords_map()
