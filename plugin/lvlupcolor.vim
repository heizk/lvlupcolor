let g:lvlupcolor_debug = 0

" set default color g:lvlupcolor_schemes
if !exists("g:lvlupcolor_schemes")
	if g:lvlupcolor_debug
		echo "lvlupcolor: using default value for lvlupcolor_schemes"
	endif
	let g:lvlupcolor_schemes = ['darkblue', 'delek' ] 
endif


" set default values for the number of lines for each level
if !exists("g:lvlupcolor_lines_per_level")
	if g:lvlupcolor_debug
		echo "lvlupcolor: using default value for lines per level"
	endif
	let g:lvlupcolor_lines_per_level = 100 
endif


if !exists("g:lvlupcolor_use_loglevels")
	let g:lvlupcolor_use_loglevels = 0
endif

" get the number of lines in current buffer
function! GetNumLines()
	return line('$') 
endfunction

" check if it is time for a color switch
function! CheckColorSwitch()
	" get the number of lines
	let lines = GetNumLines()
	" apply log scaling if wanted
	if g:lvlupcolor_use_loglevels == 1
		let lines = float2nr(log10(lines))
	endif
	" lines since last level up
	let linesSinceLastLevel = lines%g:lvlupcolor_lines_per_level
	if linesSinceLastLevel == 0
		" pick the next scheme
		let scheme = g:lvlupcolor_schemes[(lines/g:lvlupcolor_lines_per_level)%len(g:lvlupcolor_schemes)]
		" try to apply
		try
			execute "colorscheme ".scheme
		catch
			echom "lvlupcolor: could not set color scheme: ".scheme
		endtry
	endif
endfunction 

" install the event based function call
autocmd CursorMovedI * :call CheckColorSwitch()
