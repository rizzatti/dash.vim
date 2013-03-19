let s:class = funcoo#object#class.extend()
let s:proto = {}

function! s:proto.constructor(name, keyword, docsets) dict abort "{{{
  let self.name = a:name
  let self.keyword = tolower(substitute(a:keyword, ':', '', ''))
  let self.docsets = a:docsets
endfunction
"}}}

call s:class.include(s:proto)

let dash#profile#class = s:class
