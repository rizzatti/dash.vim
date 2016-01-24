" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

let s:groups = dash#defaults#module.groups

function! dash#add_keywords_for_filetype(filetype) "{{{
  let keywords = get(s:groups, a:filetype, [])
  call s:add_buffer_keywords("", keywords)
endfunction
"}}}

function! dash#autocommands() "{{{
  if g:dash_autocommands != 1
    return
  endif
  if has('autocmd')
    augroup DashVim
      autocmd!
      for pair in items(s:groups)
        let filetype = pair[0]
        execute "autocmd FileType " .  filetype . " call dash#add_keywords_for_filetype('" . filetype . "')"
      endfor
    augroup END
  endif
endfunction
"}}}

function! dash#complete(arglead, cmdline, cursorpos) "{{{
  return []
endfunction
"}}}

function! dash#keywords(bang, ...) "{{{
  if a:0 == 0
    call s:show_buffer_keywords()
  else
    call s:add_buffer_keywords(a:bang, a:000)
  endif
endfunction
"}}}

function! dash#search(bang, ...) "{{{
  let term = get(a:000, 0, expand('<cword>'))
  let keywords = []
  if !empty(a:bang) " global search
    call s:search(term, keywords)
    return
  endif
  let keyword = get(a:000, 1, '')
  if !empty(keyword) " keyword given
    call add(keywords, keyword)
  else
    let filetype = get(split(&filetype, '\.'), -1, '')
    if exists('b:dash_keywords')
      if v:count == 0
        call extend(keywords, b:dash_keywords)
      else
        let position = v:count1 - 1
        let keyword = get(b:dash_keywords, position, filetype)
        call add(keywords, keyword)
      endif
    else
      call add(keywords, filetype)
    endif
  endif
  call s:search(term, sort(keywords))
endfunction
"}}}

function! s:add_buffer_keywords(bang, keyword_list) "{{{
  let keywords = []
  if empty(a:bang) && exists('b:dash_keywords')
    let keywords = b:dash_keywords
  endif
  for item in a:keyword_list
    if index(keywords, item) == -1
       call add(keywords, item)
    endif
  endfor
  let b:dash_keywords = keywords
endfunction
"}}}

function! s:load_dash_map() "{{{
  if !exists('g:dash_map_loaded') && exists('g:dash_map') && type(g:dash_map) == type({})
    for pair in items(g:dash_map)
      let ftype = pair[0]
      let docsets = pair[1]

      if (type(docsets) == type([]))
        let s:groups[ftype] = docsets
      elseif (type(docsets) == type(""))
        if (!has_key(s:groups, ftype))
          let s:groups[ftype] = []
        else
          call filter(s:groups[ftype], 'v:val != "' . docsets . '"')
        endif
        call insert(s:groups[ftype], docsets)
      endif

      unlet ftype
      unlet docsets
    endfor
    let g:dash_map_loaded = 1
  endif
endfunction
"}}}

function! s:search(term, keywords) "{{{
  let keys = ''
  if !empty(a:keywords)
    let keys = 'keys=' . join(a:keywords, ',') . '&'
  endif
  let query = 'query=' . a:term
  if (exists('g:dash_activate') && g:dash_activate == 0)
    let activation = '&prevent_activation=true'
  else
    let activation = ''
  endif
  let url = 'dash-plugin://' . shellescape(keys . query . activation)
  silent execute '!open -g ' . url
  redraw!
endfunction
"}}}

function! s:show_buffer_keywords() "{{{
  redraw
  if !exists("b:dash_keywords") || empty(b:dash_keywords)
    echo "There are no keywords set for the current buffer."
  else
    echo "Keywords: " . join(b:dash_keywords, " ")
  endif
endfunction
"}}}

call s:load_dash_map()
