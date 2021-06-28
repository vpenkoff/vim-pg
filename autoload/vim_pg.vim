" =============================================================================
" Filename: autoload/vim_pg.vim
" Author: vpenkoff
" License: MIT License
" =============================================================================

let s:save_cpo = &cpo
set cpo&vim
let s:_ = 1

let s:space = " "

function! vim_pg#PsqlCommand(...)
    let sql = join(a:000, s:space)
    let sh_cmd = g:psql_command . s:space . PgBuildConnStr() . s:space . PgPrepareDisplay() . " -c" . s:space . "'" . sql . "'"

    let result = system(sh_cmd)
    split __tmp__
    normal! ggdG
    setlocal buftype=nofile
    call append(0, split(result, '\v\n'))
    return
endfunction


function PgBuildConnStr()
    let pg_config = PgBuildConfig()
    let host_config = pg_config[g:VimPgDbHostname]
    let connection_string = " -h " . host_config["hostname"] . " -p " . host_config["port"] . " -U " . host_config["dbuser"] . " -d " .  host_config["dbname"]
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

let &cpo = s:save_cpo
unlet s:save_cpo
