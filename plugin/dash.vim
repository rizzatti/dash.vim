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

"{{{ dash commands
if exists(':Dash') == 2
  echohl WarningMsg
  echomsg 'dash.vim: could not create command Dash'
  echohl None
else
  let definition = 'command -bang -nargs=? Dash '
  let callee = 'call dash#run("<bang>", <f-args>)'
  execute definition callee

  "{{{ <Plug> mappings
  noremap <script> <unique> <Plug>DashFiletype <SID>DashFiletype
  noremap <SID>DashFiletype :Dash <C-r>=expand('<cword>')<CR><CR>
  noremap <script> <unique> <Plug>DashGlobal <SID>DashGlobal
  noremap <SID>DashGlobal :Dash! <C-r>=expand('<cword>')<CR><CR>
  "}}}
endif
"}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
