let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor(dict) dict abort "{{{
  let self.name = get(a:dict, 'docsetName', 'No name')
  let self.path = get(a:dict, 'docsetPath', '')
  let self.platform = get(a:dict, 'platform', '')
  let self.keyword = substitute(get(a:dict, 'keyword', ':'), ':', '', '')
endfunction
"}}}

call s:class.include(s:proto)

let dash#docset#class = s:class
