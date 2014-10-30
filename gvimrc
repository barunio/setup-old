" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
 " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
 let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

 " ag is fast enough that CtrlP doesn't need to cache
 let g:ctrlp_use_caching = 0
endif

" No audible bell
set vb

" No toolbar
set guioptions-=T

" Use console dialogs
set guioptions+=c

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

" Command-Shift-F for Ack
nmap <D-F> :Ack<space>
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
map  <silent> <D-w> <Esc>:call CloseOrEmpty()<CR>
map! <silent> <D-w> <Esc>:call CloseOrEmpty()<CR>

map  <silent> <D-1> <Esc>:NERDTree<CR>
map! <silent> <D-1> <Esc>:NERDTree<CR>
map  <silent> <D-2> <Esc>:NERDTreeClose<CR>
map! <silent> <D-2> <Esc>:NERDTreeClose<CR>
map  <silent> <D-3> <Esc>:NERDTreeFind<CR>
map! <silent> <D-3> <Esc>:NERDTreeFind<CR>

" map Ctrl-P to Commant-T
" also disable built-in Command-T functionality
macmenu &File.New\ Tab key=<nop>
macmenu &File.Open\ Tab\.\.\. key=<nop>
map <D-t> :CtrlP<CR>
imap <D-t> <ESC>:CtrlP<CR>
