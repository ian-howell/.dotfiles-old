# Use python3 by default
alias python=python3
# Because I suck at keyboards
alias pyhton=python3

# Git aliases
alias gst="git status"
alias glo="git log"
alias gbr="git branch"
alias gdi="git diff"

# You never use ls the way its supposed to be used, so here:
# note that this also keeps color
alias ls='ls --color=auto -lh'
alias lsa="ls -a"

# List only directories in the current directory
alias lsd="ls -l | grep ^d"

# Count all the directories in the current directory
alias countdir="ls -l | grep ^d | wc -l"

# Safety first
alias mv="mv -i"
alias cp="cp -i"

# Easy shutdown
alias die="sudo poweroff now"

# Vim auto window splitter
if [ -e /usr/bin/nvim ]
then
  alias vim="nvim -O"
  alias cim="nvim -O"
else
  alias vim="vim -O"
  alias cim="vim -O"
fi

# Open in default without needing that dumb hyphen
alias dopen="xdg-open"

# Vim-like exit for bash
alias :q=exit
alias :wq=exit

# Ignore binaries/directories
alias grep="grep -IHdskip --color=auto"
