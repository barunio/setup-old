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
nmap   <D-]>   mq^<C-V>>`q<Right><Right>
imap   <D-]>   <Esc><D-]>i
vmap   <D-]>   >gv
smap   <D-]>   <C-O>><Esc>gv

nmap   <D-[>   mq$v<`q<Left><Left>
imap   <D-[>   <Esc><D-[>i
vmap   <D-[>   <gv
smap   <D-[>   <C-O><<Esc>gv

" Command-T for PeepOpen
macmenu &File.New\ Tab key=<D-T>
map  <D-t> <Plug>PeepOpen
map! <D-t> <C-[><Plug>PeepOpen


" Command-Return for fullscreen
macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

" Command-Shift-F for Ack
nmap <D-F> :Ack<space>-Q<space>
smap <D-F> <Esc>:Ack<space>
map! <D-F> <Esc>:Ack<space>

" Command-W hurts my wrist. just use w instead
map w <C-w>
map w- <C-w>K<C-w>_

" Simpler mapping to get into normal mode from insert mode
macmenu &Tools.Spelling.To\ Next\ error key=<nop>
map! <D-;> <Esc><Right>

" Command-o to open a file
macmenu &File.Open\.\.\. key=<nop>
map <D-o> :edit<space>
map! <D-o> <C-O><D-o>

" go to next window, round-robin 
map    <M-Tab>     <C-W>w
imap   <M-Tab>     <C-O><C-W>w
map    <M-S-Tab>   <C-W>W
imap   <M-S-Tab>   <C-O><C-W>W


macmenu &File.Close key=<nop>
map <silent> <D-w> <Esc>:call CloseOrEmpty()<CR>
map! <silent> <D-w> <Esc>:call CloseOrEmpty()<CR>

map <silent> <D-1> <Esc>:NERDTree<CR>
map! <silent> <D-1> <Esc>:NERDTree<CR>
map <silent> <D-2> <Esc>:call HideNERDTree()<CR>
map! <silent> <D-2> <Esc>:call HideNERDTree()<CR>


function HideNERDTree()
  if exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
    execute 'NERDTree | q'
  end
endfunction

