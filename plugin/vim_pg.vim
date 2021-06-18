" =============================================================================
" Filename: plugin/vim_pg.vim
" Author: vpenkoff
" License: MIT License
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:psql_command")
  let g:psql_command = "psql"
end
augroup vimpg
  nnoremap <buffer> <leader>B :call vim_pg#OpenPsql()<cr>
  vnoremap  <leader>b :call vim_pg#PsqlCommand()<cr>
augroup END
let &cpo = s:save_cpo
unlet s:save_cpo
