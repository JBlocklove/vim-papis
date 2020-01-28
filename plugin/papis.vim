" Currently trying to use OnExit to get the output of the interactive papis
function! OnExit(job_id,data,event)
	let g:citation_val=getline(1,'$')
	close
	call s:papis_cite()
endfunction

" Uses nvim's termopen to open an interactive terminal with papis. Should
" return the ref of the document and call OnExit
function! s:get_papis_ref()
	below new | set nonumber | set norelativenumber | call termopen('papis list --format "{doc[ref]}"',{'on_exit': 'OnExit'}) | startinsert
endfunction

" Prints the citation string
function! s:papis_cite()
	let l:cite_string='\cite{'.get(g:citation_val,0).'}'
	exe 'normal! a'.l:cite_string
endfunction

command! -bang -nargs=* Papis call s:get_papis_ref()
