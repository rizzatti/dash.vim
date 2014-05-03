" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor() dict abort "{{{
  let self._keywords = []
endfunction
"}}}

function! s:proto.keywords() dict abort "{{{
  return self._keywords
endfunction
"}}}

call s:class.include(s:proto)

let dash#cache#class = s:class
