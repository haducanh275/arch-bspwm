# =========================
# BASIC
# =========================
export TERM=xterm-256color
export EDITOR=nvim

# =========================
# HISTORY
# =========================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

setopt appendhistory
setopt sharehistory

# =========================
# COMPLETION
# =========================
autoload -Uz compinit
compinit

# =========================
# KEYBIND (Windows-friendly)
# =========================
bindkey "^[[1;5C" forward-word   # Ctrl + Right
bindkey "^[[1;5D" backward-word  # Ctrl + Left

# =========================
# ALIASES (must-have)
# =========================
alias ls='ls --color=auto'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias q='exit'

# pacman shortcuts
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rns'

# git shortcuts
alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'

# =========================
# PROMPT (clean)
# =========================
autoload -Uz colors && colors

PROMPT='%F{blue}%n@%m%f %F{cyan}%~%f %# '

# =========================
# EXTRAS
# =========================
# enable colors for grep
export GREP_OPTIONS='--color=auto'

# fastfetch on start (optional)
command -v fastfetch >/dev/null && fastfetch