" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = funcoo#object#class.extend()

function! s:class.sort(left, right) dict abort "{{{
  if a:left.name == a:right.name
    return 0
  endif
  return a:left.name > a:right.name ? 1 : -1
endfunction
"}}}

let s:proto = {}

let s:special_cases = {
      \  "Python 2:python" : 'python2',
      \  "Python 3:python" : 'python3',
      \  "Java SE7:java" : 'java7',
      \  "Java SE6:java" : 'java6',
      \  "Qt 5:qt" : 'qt5',
      \  "Qt 4:qt" : 'qt4',
      \  "Cocos3D:cocos2d" : 'cocos3d'
      \  }

function! s:proto.constructor(dict) dict abort "{{{
  let self.name = get(a:dict, 'docsetName', 'No name')
  let self.path = get(a:dict, 'docsetPath', '')
  let self._platform = get(a:dict, 'platform', '')
  let self._keyword = substitute(get(a:dict, 'keyword', ''), ':', '', '')
  call self._handleSpecialCases()
endfunction
"}}}

function! s:proto._handleSpecialCases() dict abort "{{{
  if !empty(self._keyword)
    return
  endif
  let key = join([self.name, self._platform], ':')
  let self._keyword = get(s:special_cases, key, '')
endfunction
"}}}

function! s:proto.keyword() dict abort "{{{
  let value = empty(self._keyword) ? self._platform : self._keyword
  return tolower(value)
endfunction
"}}}

call s:class.include(s:proto)

let dash#docset#class = s:class
