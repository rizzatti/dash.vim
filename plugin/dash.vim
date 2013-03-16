" Description: Search Dash.app from vim
" Author: Zeh Rizzatti <zehrizzatti@gmail.com>
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
  noremap <script> <unique> <Plug>DashFiletype <SID>DashFiletype
  noremap <SID>DashFiletype :Dash<CR>
  noremap <script> <unique> <Plug>DashGlobal <SID>DashGlobal
  noremap <SID>DashGlobal :Dash!<CR>
  "}}}
endif
"}}}

"{{{ DashDocsets command
if exists(':DashListDocsets') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashListDocsets'
  echohl None
else
  command -nargs=0 DashListDocsets call dash#list_docsets()
endif
"}}}

"{{{ DashDocsets command
if exists(':DashSetDocsets') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command DashSetDocsets'
  echohl None
else
  command -complete=customlist,dash#complete -nargs=* DashSetDocsets call dash#set_docsets(<f-args>)
endif
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
