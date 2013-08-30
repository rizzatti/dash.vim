" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:docset = dash#docset#class
let s:plist = funcoo#plist#module
let s:profile = dash#profile#class

let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor() dict abort "{{{
  call self._createDocsetList()
  call self._createDocsetPathMap()
  call self._createProfileList()
  let self._keywords = []
endfunction
"}}}

function! s:proto._createDocsetList() dict abort "{{{
  let docsetList = eval(s:plist.read('com.kapeli.dash docsets'))
  let docsets = []
  for docset in docsetList
    call add(docsets, s:docset.new(docset))
  endfor
  call sort(docsets, s:docset.sort, s:docset)
  let self.docsets = docsets
endfunction
"}}}

function! s:proto._createDocsetPathMap() dict abort "{{{
  let paths = {}
  for docset in self.docsets
    let paths[docset.path] = docset
  endfor
  let self._pathMap = paths
endfunction
"}}}

function! s:proto._createProfileList() dict abort "{{{
  let profileList = eval(s:plist.read('com.kapeli.dash profiles'))
  let profiles = []
  for profile in profileList
    let triggers = get(profile, 'triggers', [])
    if !empty(triggers)
      for trigger in triggers
        if get(trigger, 'isKeywordTrigger')
          break
        endif
      endfor
      let keyword = get(trigger, 'keyword', '')
      let name = get(profile, 'name', 'No name')
      let docsets = map(get(profile, 'docsets', []), 'self._pathMap[v:val]')
      call add(profiles, s:profile.new(name, keyword, docsets))
    endif
  endfor
  let self.profiles = profiles
endfunction
"}}}

function! s:proto.keywords() dict abort "{{{
  if !empty(self._keywords)
    return self._keywords
  endif
  call extend(self._keywords, map(copy(self.profiles), "v:val.keyword"))
  call extend(self._keywords, map(copy(self.docsets), "v:val.keyword()"))
  call sort(self._keywords)
  return self._keywords
endfunction
"}}}

call s:class.include(s:proto)

let dash#cache#class = s:class
