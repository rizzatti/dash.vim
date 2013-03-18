" Description: Search Dash.app from vim
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

"{{{ Dash command
if exists(':Dash') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command Dash'
  echohl None
else
  command -bang -complete=customlist,dash#complete -nargs=* -count=1 Dash call dash#run("<bang>", <f-args>)

  "{{{ <Plug> mappings
  noremap <script> <unique> <Plug>DashDocset <SID>DashDocset
  noremap <SID>DashDocset :Dash<CR>
  noremap <script> <unique> <Plug>DashGlobal <SID>DashGlobal
  noremap <SID>DashGlobal :Dash!<CR>
  "}}}
endif
"}}}

"{{{ DashGetDocsets command
if exists(':DashDocsets') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashDocsets'
  echohl None
else
  command -complete=customlist,dash#complete -nargs=* DashDocsets call dash#docsets(<f-args>)
endif
"}}}

"{{{ DashListDocsets command
if exists(':DashListDocsets') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashListDocsets'
  echohl None
else
  command -nargs=0 DashListDocsets call dash#list_docsets()
endif
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
