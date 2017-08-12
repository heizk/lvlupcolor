let g:darkschemes = ['darkblue', 'default', 'delek', 'desert', 'elford', 'koehler', 'pablo' ] 
let g:linesPerColor = 10

function! GetNumLines()
	return line('$') 
endfunction

function! CheckColorSwitch()
	let lines = GetNumLines()
	if lines%g:linesPerColor == 0
		let g:scheme = g:darkschemes[(GetNumLines()/g:linesPerColor)%len(g:darkschemes)]
		execute "colorscheme ".g:scheme
	endif
endfunction 

autocmd CursorMovedI * :call CheckColorSwitch()
