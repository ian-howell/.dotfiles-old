" Plugins
call plug#begin()

Plug 'altercation/vim-colors-solarized'
Plug 'fatih/vim-go'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'einfachtoll/didyoumean'
Plug 'wellle/targets.vim'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
"Make Git gutter work faster
set updatetime=250

Plug 'romainl/vim-cool'
" Plug 'romainl/vim-qf'
" Don't open the quickfix window automatically
let g:qf_auto_open_quickfix = 0
Plug 'tpope/vim-unimpaired'

Plug 'jsfaint/gen_tags.vim'

if v:version >= 800
    Plug 'skywind3000/asyncrun.vim'
    Plug 'w0rp/ale'
    let g:ale_python_flake8_executable = 'python3'
    let g:ale_python_flake8_options = '-m flake8'
    let g:ale_linters = {'go': ['go build', 'gofmt', 'golint']}
endif

call plug#end()
"End Plugins


"===[ (Just kidding) ]==="
"For filestype specific things (like syntax highlighting)
filetype plugin indent on
"For more matching. See :h matchit
runtime macros/matchit.vim


"===[ Set Leader ]==="
let mapleader=" "|              "Set leader key to the spacebar


"===[ Sane backspace ]==="
set backspace=indent,eol,start


"===[ Colors ]==="
syntax enable

silent! colorscheme solarized
set background=dark
let g:solarized_termcolors=256
if $COLORTERM == 'gnome-terminal'
  set t_Co=256
endif

"===[ Search behaviour ]==="
set incsearch                        "Lookahead as search pattern is specified

"===[ Tab behaviour ]==="
set tabstop=4          "Tabs are equal to 2 spaces
set shiftwidth=4       "Indent/outdent by 2 columns
set shiftround         "Indents always land on a multiple of shiftwidth
set smarttab           "Backspace deletes a shiftwidth's worth of spaces
set expandtab          "Turns tabs into spaces
set autoindent         "Keep the same indentation level when inserting a new line
set smartindent        "Add proper indentation for code, eg insert a tab after a '{' character

augroup make_file
    autocmd!
    autocmd FileType make setlocal noexpandtab          "Use tabs in makefiles
augroup END

inoremap # X#|       "Because indent is retarded with Python comments...


"===[ Line and column display settings ]==="
"== Lines =="
set nowrap             "Don't word wrap
"Unless it's a LaTeX or txt file
augroup line_wrapper
    autocmd!
    autocmd FileType tex,text,markdown setlocal wrap
    autocmd FileType tex,text,markdown nnoremap j gj
    autocmd FileType tex,text,markdown nnoremap k gk
    autocmd FileType tex,text,markdown xnoremap j gj
    autocmd FileType tex,text,markdown xnoremap k gk
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
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END
augroup highlight_follows_vim
    autocmd!
    autocmd FocusGained * setlocal cursorline
    autocmd FocusLost * setlocal nocursorline
augroup END

"== Columns =="
set sidescroll=1                           "Set horizontal scroll speed
set colorcolumn=80


"=== [ Windows and splitting ]==="
set splitright       "Put vertical splits on the right rather than the left
set splitbelow       "Put horizontal splits on the bottom rather than the top

"Mapping for more convenient 'window mode'
nnoremap <space>w <C-w>


"===[ Miscellaneous key mappings ]==="
inoremap jk <ESC>|              "Shortcut from insert to normal mode
cnoremap jk <C-c>|              "Shortcut from command to normal mode
"Because I'm apparently really bad at keyboards...
inoremap Jk <ESC>
cnoremap Jk <C-c>
inoremap JK <ESC>
cnoremap JK <C-c>
inoremap jK <ESC>
cnoremap jK <C-c>

inoremap <F1> <ESC>|            "Disable help screen on F1. Change it to <ESC>

nnoremap <space>s :source ~/.vimrc<CR>|     "Quickly source vimrc

" inoremap {{ {<CR>}<ESC>kA|                   "Fast bracketing
inoremap {{ {<CR>}<UP><END>

nnoremap Y y$|                  "Yank to EOL like it should
nnoremap <space>y "+y|         "Copy to system clipboard from normal mode
xnoremap <space>y "+y|         "Copy to system clipboard from visual mode
nnoremap <space>p "+p|         "Paste from system clipboard in normal mode
nnoremap <space>P "+P|         "Paste from system clipboard in normal mode
xnoremap <space>p "+p|         "Paste from system clipboard in visual mode

nnoremap <F1> <Esc>              "Disable help screen on F1
inoremap <F1> <Esc>

inoremap <buffer> </ </<C-x><C-o>|           "Auto-close html tags

"Compile latex
augroup autocompile_latex
  autocmd!
  autocmd BufWritePost *.tex AsyncRun pdflatex -output-directory '%:h' '%'
augroup END

"Build or run a project
function! Build()
    if &filetype == "python"
        :AsyncRun python3 %
    elseif &filetype == "cpp" || &filetype == "c"
        :AsyncRun -program=make
    endif
endfunction
nnoremap <F5> :call Build()<CR>


"Remove all trailing whitespace from a file
nnoremap <space>ws :%s/\s\+$//<CR>``

"fugitive.vim mappings
nnoremap <space>gst :Gstatus<CR>
nnoremap <space>glo :Glog -10<CR>
nnoremap <space>gdi :Gvdiff<CR>
nnoremap <space>gad :Gwrite<CR>
nnoremap <space>gre :Gread<CR>
nnoremap <space>gco :Gcommit<CR>
nnoremap <space>ged :Gedit<CR>

"Mappings for working with diffs in visual mode
xnoremap <space>do :diffget<CR>
xnoremap <space>dp :diffput<CR>


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
command! QA qa
command! Qa qa
command! W w
command! WQ wq
command! Wq wq
command! WQa wqa
command! Wqa wqa


"===[ Folds ]==="
set foldmethod=indent            "Create folds on C-likes
set foldlevel=999                "Start vim with all folds open


"===[ Show undesirable hidden characters ]==="
set listchars=tab:│\ ,trail:·,nbsp:~
highlight clear SpecialKey

augroup VisibleNaughtiness
    autocmd!
    autocmd BufEnter  *       setlocal list
    autocmd BufEnter  *.txt   setlocal nolist
    autocmd BufEnter  *.vp*   setlocal nolist
    autocmd BufEnter  *       if !&modifiable
    autocmd BufEnter  *           setlocal nolist
    autocmd BufEnter  *       endif
augroup END


"===[ Tags ]==="
set tags=./tags;,tags;
" Disable gtags support
let g:loaded_gentags#gtags = 1
" Generate tags automatically (if using git)
let g:gen_tags#ctags_auto_gen = 1
" Use git/tags_dir if using git
let g:gen_tags#use_cache_dir = 0
nnoremap <space>tt :GenCtags<CR>
nnoremap <space>tj :tjump /
nnoremap <space>tp :ptjump /


"===[ Persistant Undos ]==="
set undofile
set undodir=$HOME/.vim/undo


"===[ File navigation ]==="
"Allow changed buffers to be hidden
set hidden

"Recursively search current directory
set path=.,,**

"Shortcut to find files
nnoremap <space>ff :find *
nnoremap <space>fs :sfind *
nnoremap <space>fv :vert sfind *

"Shortcut to show buffers
nnoremap <space>b :ls<CR>:b<space>


"===[ Grep customization ]==="
let &grepprg='grep -nrsHI --exclude=tags --exclude-dir=\*venv\* --exclude-dir=.git'
nnoremap <space>/ :AsyncRun! -post=botright\ copen -program=grep<space>
nnoremap <space>* :AsyncRun! -post=botright\ copen -program=grep <cword><CR>


"===[ QuickFixList Shortcuts ]==="
nnoremap <space>cn :cnext<CR>
nnoremap <space>cp :cprevious<CR>
nnoremap <space>cc :call asyncrun#quickfix_toggle(8)<cr>

"===[ Skeleton files ]==="
augroup skeletons
  autocmd!
  autocmd BufNewFile main.* silent! execute '0r ~/.vim/skeletons/skeleton-main.' . expand("<afile>:e")
  autocmd BufNewFile *.* silent! execute '0r ~/.vim/skeletons/skeleton.' . expand("<afile>:e")

  autocmd BufNewFile * %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END


"===[ Wildmenu ]==="
set wildmenu
set wildmode=full
set wildignore+=*.o,*.so
set wildignore+=*.d
set wildignore+=*.aux,*.out,*.pdf
set wildignore+=*.pyc,__pycache__
set wildignore+=*.tar,*.gz,*.zip,*.bzip,*.bz2
set wildignore+=tags
set wildignore+=/home/**/*venv*/**
set wildignore+=*.class
set wildignore+=%*


"===[ Unsorted ]==="
set noswapfile
