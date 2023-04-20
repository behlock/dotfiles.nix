# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix

############
# UTILITIES
############
# safe source
function safe_source {
  [ -f "$1" ] && source "$1"
}

# check if program is available
function has_program {
  hash $1 2>/dev/null
}

function is_vim_running {
  jobs | grep -o 'vim' &> /dev/null
}

function is_direnv_dir {
  [[ -n "${DIRENV_DIR}" ]]
}

# go back n directories
function b {
    str=""
    count=0
    while [ "$count" -lt "$1" ];
    do
        str=$str"../"
        let count=count+1
    done
    cd $str
}

# extract files: depends on zip, unrar and p7zip
function ex {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via ex()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# find or create tmux session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# [f]uzzy check[o]ut
function fo {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}

# mkdir && cd
function mkcd {
  mkdir -p "$1" && cd "$1";
}

##############
# BASIC SETUP
##############
typeset -U PATH
autoload colors; colors;

setopt prompt_subst
setopt glob_dots

## Colored manpages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;91m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;93m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;92m'

## Load direnv
has_program direnv && eval "$(direnv hook zsh)"

#########
# PROMPT
#########
function git_prompt_info {
  local dirstatus=" OK"
  local dirty="%{$fg_bold[red]%} X%{$reset_color%}"

  if [[ ! -z $(git status --porcelain 2> /dev/null | tail -n1) ]]; then
    dirstatus=$dirty
  fi

  ref=$(git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return
  echo " %{$fg_bold[white]%}${ref#refs/heads/}$dirstatus%{$reset_color%}"
}

local dir_info_color="%{$fg_bold[grey]%}"
local dir_info="%{$dir_info_color%}%(5~|%-1~/.../%2~|%4~)%{$reset_color%}"
local prompt_normal="φ %{$reset_color%}"
local prompt_jobs="%{$fg_bold[red]%}φ %{$reset_color%}"
# local prompt_direnv="\$(is_direnv_dir && echo \"*\")"

PROMPT='${dir_info}$(git_prompt_info) %(1j.$prompt_jobs.$prompt_normal)'

# Change cursor style depending on vim mode
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

# Use beam shape cursor on startup
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

#############
# COMPLETION
#############
autoload -Uz compinit

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end
setopt auto_pushd

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

###############
# KEY BINDINGS
###############
# Vim Keybindings
bindkey -v

# Open line in Vim by pressing 'v' in Command-Mode
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Make up/down arrow put the cursor at the end of the line
# instead of using the vi-mode mappings for these keys
bindkey "\eOA" up-line-or-history
bindkey "\eOB" down-line-or-history
bindkey "\eOC" forward-char
bindkey "\eOD" backward-char

# CTRL-R to search through history
bindkey '^R' history-incremental-search-backward
# Accept the presented search result
bindkey '^Y' accept-search

# Use the arrow keys to search forward/backward through the history,
# using the first word of what's typed in as search word
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Backspace working the way it should
bindkey '^?' backward-delete-char
bindkey '^[[3~' delete-char

# Accept autosuggestions
bindkey '^ ' autosuggest-accept

#########
# ALIASES
#########
# Config
alias config='vi $HOME/.config/nixpkgs'

# Vim
alias neoc='vi $HOME/PersonalProjects/dotfiles/init.vim'

# Zsh
alias zshrc='vi $HOME/PersonalProjects/dotfiles/zshrc'
alias szh='source $HOME/PersonalProjects/dotfiles/zshrc'

# Tmux 
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tmuxconf='vi $HOME/PersonalProjects/dotfiles/tmux.conf'

# SSH
alias sshconf='vi $HOME/PersonalProjects/dotfiles/sshconfig'

# Git
alias gch='git checkout'
alias gchm='git checkout main'
alias gchma='git checkout master'
alias gchb='git checkout -b'
alias gl='git pull'
alias gd='git diff'
alias gst='git status'
alias ga='git add -A'
alias gc='git commit -m'
alias gp='git push'
alias gs='git stash'
alias gsp='git stash pop'
alias gre='git rebase'
alias glog='git log --format=%B -n 1 HEAD'
alias gcomp='nvim -p $(git diff --name-only HEAD~1 HEAD) -c "tabdo :Gdiff HEAD~1"'
alias gitconf='vi $HOME/PersonalProjects/dotfiles/gitconfig'
alias lg='lazygit'

# Projects
## Personal
alias projects='cd $HOME/Projects'
alias pp='cd $HOME/PersonalProjects'
alias ep='cd $HOME/ExternalProjects'
alias df='cd $HOME/PersonalProjects/dotfiles'
alias gopro='cd /Volumes/Go\ Pro/DCIM/100GOPRO && rm -rf *.THM'
alias opf='cd $HOME/PersonalProjects/onepointfive'
alias bxyz='cd $HOME/PersonalProjects/behlock.xyz'
alias ccg='cd $HOME/PersonalProjects/collective-creation-games'
alias resume='cd $HOME/PersonalProjects/resume'

## Python
alias py='python'

## JS
alias prd='npm run dev'

## Elm
alias ys='npm run clear-cache && PARCEL_ELM_NO_DEBUG=true npm start'
alias yf='npm run format'
alias yr='npm run review --fix'

## Infra
alias k='kubectl'
alias tf='terraform'

## Misc
alias ytdl='yt-dlp -x -f bestaudio'
