" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

if exists('loaded_dash') || &compatible || v:version < 700
  finish
endif

if has('win32') || match(system('uname'), 'Darwin') == -1
  finish
endif
let loaded_dash = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

"{{{ Load funcoo.vim
if !exists('g:loaded_funcoo')
  let funcoo = findfile('plugin/funcoo.vim', &runtimepath)
  if empty(funcoo)
    echohl WarningMsg
    echomsg 'dash.vim: dependencies are not met. please install funcoo.vim'
    echohl None
    finish
  endif
endif
"}}}

"{{{ Dash command
if exists(':Dash') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command Dash'
  echohl None
else
  command -bang -complete=customlist,dash#complete -nargs=* -count=1 Dash call dash#search("<bang>", <f-args>)

  "{{{ <Plug> mappings
  noremap <script> <unique> <Plug>DashSearch <SID>DashSearch
  noremap <SID>DashSearch :Dash<CR>
  noremap <script> <unique> <Plug>DashGlobalSearch <SID>DashGlobalSearch
  noremap <SID>DashGlobalSearch :Dash!<CR>
  "}}}
endif
"}}}

"{{{ DashKeywords command
if exists(':DashKeywords') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashKeywords'
  echohl None
else
  command -complete=customlist,dash#complete -nargs=+ DashKeywords call dash#keywords(<f-args>)
endif
"}}}

"{{{ DashSettings command
if exists(':DashSettings') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashSettings'
  echohl None
else
  command -nargs=0 DashSettings call dash#settings()
endif
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
