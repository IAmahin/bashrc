# ▗▄▄▖  ▗▄▖  ▗▄▄▖▗▖ ▗▖
# ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌
# ▐▛▀▚▖▐▛▀▜▌ ▝▀▚▖▐▛▀▜▌
# ▐▙▄▞▘▐▌ ▐▌▗▄▄▞▘▐▌ ▐▌

#Fast & Clean Bash Config — Mahin’s Power Terminal 🧠⚡

### 📦 Aliases — Short & Sweet
alias c='clear'
alias f='fastfetch'
alias go='yazi'
alias h='helix'
alias hi='sudo helix'
alias g='gedit'
alias gi='sudo gedit'
alias off='shutdown now'
alias gc='git clone'
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias cbash='helix ~/.bashrc'
alias qq='source ~/.bashrc && fastfetch'
alias f="fd . | rg "
alias tree='tree -CAhF --dirsfirst'

### 📁 Navigation
alias .='cd ..'
alias ..='cd ../..'
alias ...='cd ../../..'

### 🗃️ File Listing
alias ls="eza -a --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"

### 🚀 Pacman Shortcuts
alias ins='sudo pacman -S'
alias uins='sudo pacman -Rns'
alias updt='sudo pacman -Syu'

### 🪟 DWM Setup (Speed Run Edition)
alias s='clear && startx'
alias cstatus='cd ~/.config/slstatus && helix config.def.h'
alias restatus='cd ~/.config/slstatus && rm config.h && sudo make clean install'
alias cdwm='cd ~/.config/dwm && helix config.def.h'
alias redwm='cd ~/.config/dwm && sudo rm config.h && sudo make clean install && cd ~'
alias ii='sudo make clean install'
alias iii='sudo rm config.h && sudo make clean install'

### ⚡ Zoxide (Fast CD)
eval "$(zoxide init --cmd cd bash)"

### 🎨 Minimal Fast Prompt (Auto Root/User + Git + Icon)
PS1='$( \
  [[ $EUID -eq 0 ]] && echo -n "\[\e[1;31m\]root" || echo -n "\[\e[0;32m\]mahin" \
)\[\e[0m\]:\[\e[0;34m\]\w\[\e[0m\]$( \
  b=$(git symbolic-ref --short HEAD 2>/dev/null); \
  [[ -n "$b" ]] && echo -n " \[\e[0;33m\]($b)\[\e[0m\]" \
) \[\e[38;5;166m\]\[\e[0m\] '

### 🧠 Faster Bash Input
bind "set colored-completion-prefix on"
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
export LS_COLORS=$LS_COLORS:'di=1;34:'
eval "$(dircolors -b)"

### 🧠 FZF History (Ctrl + ↑)
__fzf_history__() {
  local entry
  entry=$(
    history | tac | awk '{
      $1=""; sub(/^ +/, "");
      split($0, a, " ");
      time=a[1] " " a[2];
      $1=$2=""; sub(/^ +/, "");
      printf "%s   %s\n", time, $0
    }' | fzf --prompt='📜 History> ' --preview='echo {}' --preview-window=up:1
  ) || return

  READLINE_LINE="${entry#*   }"
  READLINE_POINT=${#READLINE_LINE}
}
bind -x '"\e[1;5A":__fzf_history__'

### 📂 Yazi CD Support
y() {
  local tmp="$(mktemp -t yazi-cwd.XXXXXX)" cwd
  yazi "$@" --cwd-file="$tmp"
  cwd=$(<"$tmp")
  [[ -n "$cwd" && "$cwd" != "$PWD" ]] && cd "$cwd"
  rm -f "$tmp"
}

### 📝 Editor
export EDITOR=helix

### Best man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


### extract
uzip() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1" ;;
            *.tar.gz)    tar xzf "$1" ;;
            *.bz2)       bunzip2 "$1" ;;
            *.rar)       unrar x "$1" ;;
            *.gz)        gunzip "$1" ;;
            *.tar)       tar xf "$1" ;;
            *.tbz2)      tar xjf "$1" ;;
            *.tgz)       tar xzf "$1" ;;
            *.zip)       unzip "$1" ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1" ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

export TERMINAL=alacritty

HISTTIMEFORMAT="%F %T   "
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

export FZF_DEFAULT_OPTS='
  --color=fg:#ebdbb2,bg:#282828,hl:#fabd2f
  --color=fg+:#ffffff,bg+:#3c3836,hl+:#fe8019
  --color=info:#83a598,prompt:#b8bb26,pointer:#d3869b
  --color=marker:#fb4934,spinner:#8ec07c,header:#d65d0e
'
