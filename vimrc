" Plugins
call plug#begin()

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'altercation/vim-colors-solarized'
Plug 'bling/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'einfachtoll/didyoumean'
Plug 'wellle/targets.vim'

Plug 'airblade/vim-gitgutter'
"Make Git gutter work faster
set updatetime=250

Plug 'tpope/vim-fugitive'
nnoremap <F5> :Gstatus<CR>
nnoremap <F6> :Gvdiff<CR>
nnoremap <F7> :Gwrite<CR>
nnoremap <F8> :Gcommit<CR>

if has('nvim')
  "Neomake
  Plug 'benekastah/neomake'
  " Run linter asynchronously upon saving/entering buffer
  autocmd! BufWritePost * Neomake!
  " Open error list if they exist
  let g:neomake_open_list = 2

  " C++ linting
  let g:neomake_cpp_cpp11_maker = {
        \ 'exe': 'g++',
        \ 'args': ['-std=c++11'],
        \ }
  let g:neomake_cpp_enabled_makers = ['makeprg', 'cpp11']

  "Autocompletion
  if has('python3')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1

    " deoplete tab-complete
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

    Plug 'Rip-Rip/clang_complete'
    let g:clang_library_path='/usr/lib/llvm-3.6/lib/'

    Plug 'zchee/deoplete-jedi'
  else
    Plug 'ervandew/supertab'
  end

  " Markdown-composer
  if executable('cargo')
  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      !cargo build --release
    endif
  endfunction
  Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
  endif

else
  Plug 'scrooloose/syntastic'
  " Syntastic suggested defaults
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0

  Plug 'ervandew/supertab'
end

call plug#end()
"End Plugins

"===[ Set Leader ]==="
let mapleader=" "|              "Set leader key to the spacebar


"===[ Colors ]==="
syntax enable

let g:solarized_termcolors=256
colorscheme solarized
set background=dark


"===[ Search behaviour ]==="
set incsearch                        "Lookahead as search pattern is specified
set ignorecase                       "Ignore case in all searches...
set smartcase                        "...unless uppercase letters are used

set hlsearch                         "Highlight all matches
nnoremap <Leader>n :nohlsearch<CR>|      "Clear search highlights with Escape

"===[ Tab behaviour ]==="
set tabstop=2          "Tabs are equal to 2 spaces
set shiftwidth=2       "Indent/outdent by 2 columns
set smarttab           "Backspace deletes a shiftwidth's worth of spaces
set expandtab          "Turns tabs into spaces
set autoindent         "Keep the same indentation level when inserting a new line
set smartindent        "Add proper indentation for code, eg insert a tab after a '{' character

autocmd FileType make set noexpandtab          "Use tabs in makefiles

inoremap # X#|       "Because indent is retarded with Python comments...


"===[ Line and column display settings ]==="
"== Lines =="
set nowrap             "Don't word wrap
"Unless it's a LaTeX or txt file
augroup line_wrapper
    autocmd!
    autocmd FileType tex,text,markdown set wrap
    autocmd FileType tex,text,markdown nnoremap j gj
    autocmd FileType tex,text,markdown nnoremap k gk
    autocmd FileType tex,text,markdown vnoremap j gj
    autocmd FileType tex,text,markdown vnoremap k gk
    autocmd FileType tex autocmd BufWritePost * :silent execute "!pdflatex " . bufname("%") . " > /dev/null"
augroup END
set textwidth=0        "Don't automatically insert linebreaks
set relativenumber     "Give a relative number of lines from the cursor
set number             "Show the cursor's current line
set scrolloff=2        "Scroll when 2 lines from top/bottom

"Only turn on relative numbers in the active window
augroup active_relative_number
    autocmd!
    autocmd WinEnter * :setlocal number relativenumber
    autocmd WinLeave * :setlocal norelativenumber
augroup END

"Highlight the current line
"    Only highlights the active window, and only when vim is in focus
set cursorline
augroup highlight_follows_focus
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END
augroup highlight_follows_vim
    autocmd!
    autocmd FocusGained * set cursorline
    autocmd FocusLost * set nocursorline
augroup END

"== Columns =="
set sidescroll=1                           "Set horizontal scroll speed
execute "set colorcolumn=".join(range(80,335), ',')|   "Discolor every column past column 80


"=== [ Windows and splitting ]==="
set splitright       "Put vertical splits on the right rather than the left
set splitbelow       "Put horizontal splits on the bottom rather than the top

"Easily move between windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"===[ Miscellaneous key mappings ]==="
inoremap jk <ESC>|              "Shortcut from insert to normal mode
cnoremap jk <C-c>|              "Shortcut from command to normal mode
"Because I'm apparently really bad at keyboards...
inoremap Jk <ESC>
cnoremap Jk <C-c>
inoremap JK <ESC>
cnoremap JK <C-c>

inoremap <F1> <ESC>|            "Disable help screen on F1. Change it to <ESC>

nnoremap <Leader>s :source ~/.vimrc<CR>|     "Quickly source vimrc

inoremap {{ {<CR>}<ESC>kA|                   "Fast bracketing

nnoremap Y y$|                  "Yank to EOL like it should
nnoremap <Leader>y "+yy|        "Copy to system clipboard from normal mode
vnoremap <Leader>y "+y|         "Copy to system clipboard from visual mode
nnoremap <Leader>p "+p|         "Paste from system clipboard in normal mode
vnoremap <Leader>p "+p|         "Paste from system clipboard in visual mode

nnoremap <Leader>w :w<CR>|      "Quickly save from normal mode

nnoremap <F1> <Esc>              "Disable help screen on F1
inoremap <F1> <Esc>

inoremap <buffer> </ </<C-x><C-o>|           "Auto-close html tags

"Compile latex
nnoremap <Leader>tex :!pdflatex %<CR>

"===[ Statusline ]==="
set laststatus=2                             "Always show the status line
set statusline=%<%f\ %y%m%r%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%*


"===[ Fix misspellings on the fly ]==="
iabbrev          retrun           return
iabbrev           pritn           print
iabbrev         incldue           include
iabbrev         inculde           include
iabbrev         inlcude           include
iabbrev              ;t           't

command! W w
command! Q q
command! WQ wq
command! Wq wq


"===[ Folds ]==="
set foldmethod=syntax           "Create folds on C-likes
set foldlevel=20                 "Start vim with all folds open
autocmd FileType python set foldmethod=indent


"===[ Show undesirable hidden characters ]==="
" (uBB is right double angle, uB7 is middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       set list
    autocmd BufEnter  *.txt   set nolist
    autocmd BufEnter  *.vp*   set nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           set nolist
    autocmd BufEnter  *       endif
augroup END


"===[ Tags ]==="
autocmd! BufWrite * call system('ctags -R -f ./.git/tags *')

set backupdir=$HOME/.vim/backup
set directory=$HOME/.vim/swap
set undodir=$HOME/.vim/undo
