# CtrlP ag

[CtrlP][1] extension for global searching source code with ag.
Modified from [vim-ctrlp-tjump][2], another CtrlP extension that strongly recommanded.

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
    ```

## Usage

- Press `c-f` on the word you want to search (works in both normal/visual mode)
- Press `<leader>ca`, a prompt opened to ask you what to search
- Press `<leader>cp`, to redo the last ag search in CtrlP


[1]: https://github.com/kien/ctrlp.vim
[2]: https://github.com/ivalkeen/vim-ctrlp-tjump
