#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Info del sistema con imagen al abrir una terminal kitty
[[ $TERM == xterm-kitty && -z $NO_FETCH && $(tput cols 2>/dev/null || echo 0) -ge 85 ]] && command -v fastfetch >/dev/null && fastfetch
