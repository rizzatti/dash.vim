let s:plist = funcoo#plist#module
let s:docset = dash#docset#class
let s:profile = dash#profile#class

let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor() dict abort "{{{
  call self.createDocsetList()
  call self.createDocsetPathMap()
  call self.createProfileList()
endfunction
"}}}

function! s:proto.createDocsetList() dict abort "{{{
  let docsetList = eval(s:plist.read('com.kapeli.dash docsets'))
  let docsets = []
  for docset in docsetList
    call add(docsets, s:docset.new(docset))
  endfor
  let self.docsets = docsets
endfunction
"}}}

function! s:proto.createDocsetPathMap() dict abort "{{{
  let paths = {}
  for docset in self.docsets
    let paths[docset.path] = docset
  endfor
  let self.pathMap = paths
endfunction
"}}}

function! s:proto.createProfileList() dict abort "{{{
  let profileList = eval(s:plist.read('com.kapeli.dash profiles'))
  let profiles = []
  for profile in profileList
    let triggers = get(profile, 'triggers', [])
    if !empty(triggers)
      for trigger in triggers
        if trigger.isKeywordTrigger
          break
        endif
      endfor
      let keyword = get(trigger, 'keyword', '')
      let name = get(profile, 'name', 'No name')
      let docsets = map(get(profile, 'docsets', []), 'self.pathMap[v:val]')
      call add(profiles, s:profile.new(name, keyword, docsets))
    endif
  endfor
  let self.profiles = profiles
endfunction
"}}}

call s:class.include(s:proto)

let dash#cache#class = s:class
