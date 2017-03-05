command! CtrlPag call ctrlp#ag#exec('n')
command! CtrlPagPrevious call ctrlp#ag#exec('p')
command! -range CtrlPagVisual <line1>,<line2>call ctrlp#ag#exec('v')
command! -nargs=1 CtrlPagLocate call ctrlp#ag#exec(<q-args>)

if exists('g:ctrlp_ag_filter')
	let g:ctrlp_ag_filter .= ' '
else
	if !exists('g:ctrlp_ag_timeout')
		let g:ctrlp_ag_timeout = 10
	endif
	if executable('timeout')
		let g:ctrlp_ag_filter = 'timeout ' . g:ctrlp_ag_timeout . ' '
	elseif executable('gtimeout')
		let g:ctrlp_ag_filter = 'gtimeout ' . g:ctrlp_ag_timeout . ' '
	else
		let g:ctrlp_ag_filter = ''
	endif
endif

if executable('ag')
	let prg = &grepprg
	set grepprg&
	if prg ==# &grepprg
		set grepformat=%f:%l:%c:%m
		let &grepprg = g:ctrlp_ag_filter . 'ag --vimgrep --hidden $*'
	else
		let &grepprg = prg
	endif

	if !exists('g:ctrlp_user_command')
		let g:ctrlp_user_command = g:ctrlp_ag_filter . 'ag %s --nocolor --nogroup --hidden -g ""'
	endif
endif
