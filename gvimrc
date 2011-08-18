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
map    <D-]>   >gv
imap   <D-]>   >gv
map    <D-[>   <gv
imap   <D-[>   <gv

" Command-T for PeepOpen
macmenu &File.New\ Tab key=<D-T>
map             <D-t>   <Plug>PeepOpen
imap            <D-t>   <C-[><Plug>PeepOpen


" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Command-Shift-F for Ack
map <D-F> :Ack<space>
imap <D-F> :Ack<space>

" Command-W hurts my wrist. just use w instead
map w <C-w>

" Command-, toggles between insert and normal modes
imap <D-,> <Esc>
map <D-,> i

" Command-o to open a file
macmenu &File.Open\.\.\. key=<nop>
map <D-o> :edit<space> 

" go to next window, round-robin 
map    <M-Tab>     <C-W>w
imap   <M-Tab>     <C-O><C-W>w
map    <M-S-Tab>   <C-W>W
imap   <M-S-Tab>   <C-O><C-W>W
