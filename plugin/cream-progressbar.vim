"======================================================================
" cream-progressbar.vim -- draw a progress bar in the command line:
"     Loading file... [####################             ] 55%
"
" One of the many custom utilities and functions for gVim from the
" Cream project ( http://cream.sourceforge.net ), a configuration of
" Vim in the vein of Apple and Windows software you already know.
"
" Date:   7 July 2002
" Source: http://vim.sourceforge.net/scripts/script.php?script_id=242
" Author: Steve Hall  [ digitect@mindspring.com ]
" License: GPL (http://www.gnu.org/licenses/gpl.html)
"
" Instructions:
" * Simply copy this file and paste it into your vimrc. Or you can
"   drop the entire file into your plugins directory. Or you can place
"   it into another vim file you intend on loading before calling it.
"   ;)
"
" ChangeLog:
" 2002-07-07 -- Version 1.0
" * Initial release

"----------------------------------------------------------------------
"   a:percentage -- percent of bar complete
"   a:string     -- leading description string (empty acceptable)
"   a:char       -- character to use as bar (suggest "#", "|" or "*")
"   a:barlen     -- bar length in columns, use 0 to use window width
function! ProgressBar(percentage, string, char, barlen)
	
	" establish bar length (if no value passed)
	if a:barlen == 0
		"              window width  leading string   "[" "] " 63%  margin
		let barlen = winwidth(0) - strlen(a:string) - 1 - 2 - 3 - 2
	else
		let barlen = a:barlen
	endif

	" define progress
	let chrs = barlen * a:percentage / 100
	" define progress to go
	let chrx = barlen * (100 - a:percentage) / 100

	" bar, initial string and start line
	let bar = a:string . "["
	" bar, progress
	while chrs
		let bar = bar . a:char
		let chrs = chrs - 1
	endwhile
	" bar, progress to go
	while chrx
		let bar = bar . " "
		let chrx = chrx - 1
	endwhile
	" bar, end line
	let bar = bar . "] "
	" bar, extra space if single digit
	if a:percentage < 10
		let bar = bar . " "
	endif
	" bar, percentage
	let bar = bar . a:percentage . "%"

	" clear command line
	execute "normal \<C-l>:\<C-u>"

	" capture cmdheight
	let cmdheight = &cmdheight
	" setting to 2+ avoids 'Press Enter...'
	if cmdheight < 2
	    let &cmdheight = 2
	endif

	" show on command line
	echon bar

	" restore cmdheight
	let &cmdheight = cmdheight

endfunction

