#
# ~/.zshrc
#

# --- Historial ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE INC_APPEND_HISTORY
setopt AUTO_CD INTERACTIVE_COMMENTS

# --- Autocompletado con menú navegable ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# --- Teclas ---
bindkey -e
bindkey '^[[A' history-beginning-search-backward   # ↑ busca en historial lo que empiece igual
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[1;5C' forward-word                     # Ctrl+→
bindkey '^[[1;5D' backward-word                    # Ctrl+←
bindkey '^[[3~' delete-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# --- Alias con iconos ---
if command -v eza >/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --git --group-directories-first'
    alias la='eza -la --icons --git --group-directories-first'
    alias lt='eza --tree --level=2 --icons'
else
    alias ls='ls --color=auto'
fi
command -v bat >/dev/null && alias cat='bat --style=plain --paging=never'
alias grep='grep --color=auto'

# --- Herramientas ---
command -v fzf >/dev/null && source <(fzf --zsh)          # Ctrl+R: buscador de historial
command -v zoxide >/dev/null && eval "$(zoxide init zsh)" # z <carpeta>: salto rápido

# --- Plugins: sugerencia gris del comando anterior + colores al escribir ---
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#3a4452'

# --- Prompt ---
if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
else
    PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f %# '
fi

# syntax-highlighting debe cargarse al final
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Info del sistema con imagen al abrir una terminal kitty
[[ $TERM == xterm-kitty && -z $NO_FETCH && $(tput cols 2>/dev/null || echo 0) -ge 85 ]] && command -v fastfetch >/dev/null && fastfetch
