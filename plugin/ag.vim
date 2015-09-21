command! CtrlPag call ctrlp#ag#exec('n')
command! CtrlPagPrevious call ctrlp#ag#exec('p')
command! -range CtrlPagVisual <line1>,<line2>call ctrlp#ag#exec('v')
command! -nargs=1 CtrlPagLocate call ctrlp#ag#exec(<q-args>)
