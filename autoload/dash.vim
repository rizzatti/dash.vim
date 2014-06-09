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

  function! dash#add_keywords_for_filetype(...)
  endfunction

  function! dash#autocommands(...)
  endfunction

  function! dash#complete(...)
  endfunction

  function! dash#keywords(...)
    call s:dummy()
  endfunction

  function! dash#search(...)
    call s:dummy()
  endfunction

  finish
endfunction
"}}}

let s:groups = dash#defaults#module.groups

function! dash#add_keywords_for_filetype(filetype) "{{{
  let keywords = get(s:groups, a:filetype, [])
  call s:add_buffer_keywords(keywords)
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

function! dash#keywords(...) "{{{
  if a:0 == 0
    call s:show_buffer_keywords()
  else
    call s:add_buffer_keywords(a:000)
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
        call add(keywords, filetype)
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

function! s:add_buffer_keywords(keyword_list) "{{{
  let keywords = []
  if exists('b:dash_keywords')
    let keywords = b:dash_keywords
  endif
  call extend(keywords, a:keyword_list)
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
  let url = 'dash-plugin://' . shellescape(keys . query)
  silent execute '!open ' . url
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
