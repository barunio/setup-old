" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

" Local config
if filereadable($HOME . "/.gvimrc.local")
  source ~/.gvimrc.local
endif

" Fullscreen takes up entire screen
set fuoptions=maxhorz,maxvert
 
" Command-][ to increase/decrease indentation
vmap <D-]> >gv
vmap <D-[> <gv

" Command-T for PeepOpen
macmenu &File.New\ Tab key=<D-T>
map <D-t> <Plug>PeepOpen

" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Command-Shift-F for Ack
map <D-F> :Ack<space>

" Command-T for PeepOpen
macmenu &File.Open\.\.\. key=<nop>
map <D-o> :edit<space> 

" Command-e for ConqueTerm
map <D-e> :call StartTerm()<CR>

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \ 
endfunction

