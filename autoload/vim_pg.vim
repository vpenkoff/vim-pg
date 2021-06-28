" =============================================================================
" Filename: autoload/vim_pg.vim
" Author: vpenkoff
" License: MIT License
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim
let s:_ = 1

function! vim_pg#PsqlCommand()
  let result = PgExecSql()
  split __tmp__
  normal! ggdG
  setlocal buftype=nofile
  call append(0, split(result, '\v\n'))
endfunction

function PgExecSql()
  let cmd = PgBuildPsqlCommand()
  let result = system(cmd)
  return result
endfunction

function PgBuildPsqlCommand()
  let space = " "
  let sh_cmd = g:psql_command . space . PgBuildConnStr() . space . PgPrepareDisplay() . " -c" . space . "'" . PgGetVisualSelection() . "'"
  echom sh_cmd
  return sh_cmd
endfunction

function PgBuildConnStr()
  let config = PgBuildConfig()[g:VimPgDbHostname]
  let connection_string = " -h " . config["hostname"] . " -p " . config["port"] . " -U " . config["dbuser"] . " -d " . config["dbname"]
  return connection_string
endfunction

function PgBuildConfig()
  let pgpass = PgReadPgPass()
  let configs = {}

  for line in pgpass
    let props = split(line, ":")
    let config = { "hostname": props[0], "port": props[1], "dbname": props[2], "dbuser": props[3], "dbpass": props[4] }
    let configs[props[0]] = config
  endfor

  return configs
endfunction

function PgReadPgPass()
  try
    let pgpass_dest = join([glob("~/"), ".pgpass"], "")
    let pgpass = readfile(pgpass_dest)
    return pgpass
  catch /E484:/
    echo "pgpass not found"
  endtry
endfunction

function PgPrepareDisplay()
  let display_opts = "-c '\\x'"
  return display_opts
endfunction

function PgGetVisualSelection()
  " ----{{{
  " This part is taken from:
  " https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript
  let [line_start, column_start] =  getpos("'<'")[1:2]
  let [line_end, column_end] =  getpos("'>'")[1:2]
  let lines = getline(line_start, line_end)
  let selection =  join(lines, "\n")

  if len(lines) == 0
    return ''
  endif

  let lines[-1] = lines[-1][: column_end - 2]
  let lines[0] = lines[0][column_start - 1:]
  " ----}}}
  return selection
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
