" =============================================================================
" Filename: plugin/vim_pg.vim
" Author: vpenkoff
" License: MIT License
" =============================================================================

if exists("g:loaded_vim_pg")
    finish
endif
let g:loaded_vim_pg = 1

let s:save_cpo = &cpo
set cpo&vim

if !exists("g:psql_command")
  let g:psql_command = "psql"
end

vnoremap <unique> <leader>b :call vim_pg#PsqlCommand()<cr>

let &cpo = s:save_cpo
unlet s:save_cpo
