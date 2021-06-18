# vim-pg

### Intro
**vim-pg** is simple wrapper around `psql` to execute SQL queries directly to PostgreSQL. 
### Requirements
* Vim8
* [psql](https://www.postgresql.org/docs/10/app-psql.html) 
* .pgpass file, containing DB connection configuration, as described in the official [docs](https://www.postgresql.org/docs/10/libpq-pgpass.html) of PostgreSQL
### Installation
Clone the repo into your Vim plugins directory, i.e.:
```
$ git clone https://github.com/vpenkoff/vim-pg ~/.vim/pack/git-plugins/start/vim-pg
```
### Setup
Once you cloned the repo, you need to specify in your `$MYVIMRC`, which is the default hostname for your DB connection, using the following variable:
```
File: ~/.vimrc

let g:VimPgDbHostname = "sql.example.com"
```
### Running
![vim-pg](https://i.imgur.com/Bj6kvI3.png)
1. Open Vim
2. Press `<leader>B` - this will split your window in to two.
3. Enter your query
4. Mark your query with visual selection
5. Press `<leader>b` to execute the query. The result will be shown in a new split.

### Contribute
1. Fork the repo
2. Create feature/bugfix/improvement branch from `master`
3. Create new PR to `master`

### License
This software is released under the MIT License, see LICENSE.
