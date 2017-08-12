let g:darkschemes = ['darkblue', 'default', 'delek', 'desert', 'elford', 'koehler', 'pablo' ] 
let g:linesPerColor = 10

function! GetNumLines()
	return line('$') 
endfunction

function! CheckColorSwitch()
	let lines = Lines()
	if lines%g:linesPerColor == 0
		echo "switching color scheme"
		let g:scheme = g:darkschemes[(GetNumLines()/g:linesPerColor)%len(g:darkschemes)]
		execute "colorscheme ".g:scheme
	endif
endfunction 

autocmd CursorMovedI * :call CheckColorSwitch()
