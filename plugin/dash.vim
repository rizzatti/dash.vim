" Description: Search Dash.app from Vim
" Author: José Otávio Rizzatti <zehrizzatti@gmail.com>
" License: MIT

if exists('loaded_dash') || &compatible || v:version < 700
  finish
endif

if !has('unix') " OS X's vim and MacVim have this feature
  finish
endif
let loaded_dash = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

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
  command -bang -complete=customlist,dash#complete -nargs=* DashKeywords call dash#keywords("<bang>", <f-args>)
endif
"}}}

if !exists('g:dash_autocommands')
  let g:dash_autocommands = 1
  call dash#autocommands()
endif

if !exists('g:dash_activate')
  let g:dash_activate = 1
endif

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
