" Description: Search Dash.app from vim
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:docset_map = {
      \ 'python' : 'python2',
      \ 'java' : 'java7'
      \ }

let s:docsets = []
let s:initialized = 0

let s:special_cases = {
      \  "Python 2\npython" : 'python2',
      \  "Python 3\npython" : 'python3',
      \  "Java SE7\njava" : 'java7',
      \  "Java SE6\njava" : 'java6',
      \  "Qt 5\nqt" : 'qt5',
      \  "Qt 4\nqt" : 'qt4',
      \  "Cocos3D\ncocos2d" : 'cocos3d'
      \  }

let s:script = expand('<sfile>:h:h') . '/script/check_for_dash.sh'

function! s:check_for_dash() "{{{
  call system(s:script)
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
  let regex = '\v\{\_.{-}docsetName \= "?([^";]+)"?;\_.{-}(keyword \= "(.+):";\_.{-})?platform \= (\w+);\_.{-}\}'
  let position = 1
  let docsets = []
  while 1
    let matches = matchlist(plist, regex, 0, position)
    if empty(matches)
      break
    endif
    let name = get(matches, 1)
    let keyword = get(matches, 3)
    let platform = get(matches, 4)
    if empty(keyword)
      let word = get(s:special_cases, join([name, platform], "\n"), platform)
    else
      let word = keyword
    endif
    if index(docsets, word) == -1
      call add(docsets, tolower(word))
    endif
    let position += 1
  endwhile
  call sort(docsets)
  let s:docsets = docsets
endfunction
"}}}

function! s:extend_docset_map() "{{{
  if !exists('g:dash_map') || type(g:dash_map) != 4
    return
  endif
  call extend(s:docset_map, g:dash_map)
endfunction
"}}}

function! s:initialize() "{{{
  if s:initialized
    return
  endif
  call s:check_for_dash()
  call s:create_docsets_cache()
  call s:extend_docset_map()
  let s:initialized = 1
endfunction
"}}}

function! s:search(args, global) "{{{
  let word = get(a:args, 0, expand('<cword>'))
  if a:global
    let docset = ''
  else
    let filetypes = split(&filetype, '\.')
    let primary_ft = get(filetypes, -1, '')
    let ft = get(filetypes, v:count1 - 1, primary_ft)
    let docset = get(a:args, 1, ft)
    let docset = get(s:docset_map, docset, docset)
    if index(s:docsets, docset) == -1
      let docset = ''
    else
      let docset = docset . ':'
    endif
  endif
  silent execute '!open dash://' . docset . word
  redraw!
endfunction
"}}}

function! dash#available_docsets() "{{{
  call s:initialize()
  redraw
  echo "List of all docset keywords:"
  echo join(s:docsets)
endfunction
"}}}

function! dash#complete(arglead, cmdline, cursorpos) "{{{
  call s:initialize()
  if !s:dash_present
    return s:docsets
  endif
  return filter(copy(s:docsets), 'match(v:val, a:arglead) == 0')
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

function! dash#set_docsets(...) "{{{
  call s:initialize()
  let docsets = copy(a:000)
  call filter(docsets, 'index(s:docsets, v:val) != -1')
  let b:dash_docsets = docsets
endfunction
"}}}
