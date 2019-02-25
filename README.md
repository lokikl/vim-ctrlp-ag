# CtrlP ag

[CtrlP][1] extension for global searching source code with ag.
Modified from [vim-ctrlp-tjump][2], another CtrlP extension that is strongly recommended.

Automatically configures `:grep` and CtrlP to use ag unless `grepprg` or `g:ctrlp_user_command`
have been user-defined.

## Installation

1. Fire any plugin manager like Vundle

    ```
    Plugin 'lokikl/vim-ctrlp-ag'
    ```

2. Create mapping

    ```
    nnoremap <c-f> :CtrlPag<cr>
    vnoremap <c-f> :CtrlPagVisual<cr>
    nnoremap <leader>ca :CtrlPagLocate
    nnoremap <leader>cp :CtrlPagPrevious<cr>
    let g:ctrlp_ag_options = '--ignore .git
        \ --ignore "deps/*"
        \ --ignore "_build/*"
        \ --ignore "node_modules/*"'
    " By default ag will search from PWD
    " But you may enable one of below line to use an arbitrary directory or,
    " Using the magic word 'current-file-dir' to use current file base directory
    " let g:ctrlp_ag_search_base = 'current-file-dir'
    " let g:ctrlp_ag_search_base = 'app/controllers' " both relative and absolute path supported
    ```

## Usage

- Press `c-f` on the word you want to search (works in both normal/visual mode)
- Press `<leader>ca`, a prompt opened to ask you what to search
- Press `<leader>cp`, to redo the last ag search in CtrlP

## Configuration

- Set the variable `g:ctrlp_ag_filter` to a command that executes its arguments as a sub-command,
  which in turn allows filtering the results. (Default: `'timeout 10'` or `'gtimeout 10'` or
  undefined, depending on the programs you've installed)
- Set the variable `g:ctrlp_ag_timeout` to the number of seconds that the timeout filter should wait
  for ag to complete. (Default: `10`) Don't touch `g:ctrlp_ag_filter` if you want to use this
  filter.
- Set the variable `g:ctrlp_ag_search_base` to change search base from PWD to current file directory or an arbitrary directory.
  Please see the Create Mapping section for example.

[1]: https://github.com/kien/ctrlp.vim
[2]: https://github.com/ivalkeen/vim-ctrlp-tjump
