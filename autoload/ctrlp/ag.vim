if (exists('g:loaded_ctrlp_ag') && g:loaded_ctrlp_ag)
      \ || v:version < 700 || &cp
  finish
endif
let g:loaded_ctrlp_ag = 1

"
" configuration options

call add(g:ctrlp_ext_vars, {
      \ 'init': 'ctrlp#ag#init()',
      \ 'accept': 'ctrlp#ag#accept',
      \ 'lname': 'ag',
      \ 'sname': 'ag',
      \ 'type': 'line',
      \ 'enter': 'ctrlp#ag#enter()',
      \ 'exit': 'ctrlp#ag#exit()',
      \ 'opts': 'ctrlp#ag#opts()',
      \ 'sort': 0,
      \ 'specinput': 0,
      \ })

function! ctrlp#ag#exec(mode)
  let s:ag_opt_for_sensitivity = "-s"
  if a:mode == 'p'
    let s:word = s:word
  elseif a:mode == 'v'
    let s:word = s:get_visual_selection()
  elseif a:mode == 'n'
    if (&filetype == 'ruby' || &filetype == 'eruby') && exists("*RubyCursorIdentifier")
      let s:word = RubyCursorIdentifier()
    else
      let s:word = expand('<cword>')
    endif
  else
    let s:ag_opt_for_sensitivity = "-S"
    let s:word = a:mode
  endif

  if (!exists('g:ctrlp_ag_ignores'))
    let g:ctrlp_ag_ignores = "--ignore tags"
  endif

  let s:ag_results = split(system(g:ctrlp_ag_filter .
        \ "ag -Q " . s:ag_opt_for_sensitivity .
        \ " --column " . g:ctrlp_ag_ignores .
        \ " '" . s:word . "'"), "\n")

  " remove current file/line from results
  let bname = bufname('%') . ':' . line('.')
	call filter(s:ag_results, 'v:val !~ "^' . bname . '"')

  if len(s:ag_results) == 0
    echo("No results found for: ".s:word)
  else
    call ctrlp#init(ctrlp#ag#id())
  endif
endfunction

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#ag#init()
  " dim the content part to make it look more tidy
  " eg.
  " app/data/mgmt.rb:31:     def abc
  if !ctrlp#nosy()
    cal ctrlp#hicheck('CtrlPTabExtra', 'Comment')
    syntax match CtrlPTabExtra `:.*$`
  en
  return s:ag_results
endfunction

" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#ag#accept(mode, str)
  call ctrlp#exit()
  call s:open_file(a:mode, a:str)
endfunction

" (optional) Do something before enterting ctrlp
function! ctrlp#ag#enter()
endfunction

" (optional) Do something after exiting ctrlp
function! ctrlp#ag#exit()
endfunction

" (optional) Set or check for user options specific to this extension
function! ctrlp#ag#opts()
endfunction

" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#ag#id()
  return s:id
endfunction

function! s:open_file(mode, str)
  let [path, line, column; rest] = split(a:str, ':')
  call ctrlp#acceptfile(a:mode, path)
  call cursor(line, column)
endfunction

function! s:get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction
