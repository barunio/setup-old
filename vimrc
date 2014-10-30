filetype off      " disable file type detection
set nocompatible  " use Vim settings, rather then Vi settings

" set up vundle
set rtp+=~/.vim/bundle/vundle/ " add to run time path
call vundle#rc()

" let Vundle manage Vundle (required!)
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'ervandew/supertab'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-repeat'
Bundle 'vim-scripts/tComment'
Bundle 'kchmck/vim-coffee-script'

set noswapfile
set nobackup      " don't create annoying backup files
set nowritebackup " use normal save behavior (don't create temp files)
set history=200   " remember 200 lines of history
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " always display the status line
set autoindent    " copy previous line indentation on a new line
set showmode      " show current vim mode
set splitbelow    " horizontal split should go below
set splitright    " vertical split should to go the right
set nowrap        " no automatic line wrapping
set cc=80         " show a vertical line at 80 columns
syntax on         " turn on syntax highlighting
let mapleader=","

filetype plugin indent on  " allow setting indentation based on filetype

" set color scheme to Solarized Dark
set background=dark
colorscheme solarized


augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

map <space> :
set guifont=Monaco:h12

if has("gui_macvim")
  let macvim_hig_shift_movement = 1
endif

cabbrev vimrc edit ~/.vimrc
cabbrev gvimrc edit ~/.gvimrc

nmap cp :let @+ = expand('%:p')<CR>

nmap ri" ci"<Esc><Right>"0P

map <leader>t: :Tab/:\zs<CR>
map <leader>t= :Tab/=<CR>
map <leader>t\ :Tab/<bar><CR>
map <leader>t, :Tab/,\zs<CR>


" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Thanks to http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd!
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=nofile
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call <SID>Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>

function! CloseOrEmpty()
  if winnr() == winnr('$')
    if winnr() == 1
      execute 'Kwbd'
    elseif winnr() == 2 && exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1
      execute 'Kwbd'
    else
      execute 'q'
    end
  else
    execute 'q'
  end
endfunction

" delete trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
