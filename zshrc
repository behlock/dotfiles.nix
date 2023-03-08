##############
# BASIC SETUP
##############

typeset -U PATH
autoload colors; colors;

# Match hidden files too
setopt glob_dots

###########
# PLUGINS
##########

# Path to oh-my-zsh installation.
export ZSH="/Users/wbehlock/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

plugins=(
    git
    macos
)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

#########
# HISTORY
##########

HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.

setopt inc_append_history
setopt share_history

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

alias cl='clear'
alias ls='ls --color=auto'

# History
alias history='history 1'
alias hs='history | grep '

# Vim
alias vi="nvim"
alias neoc="vi ~/PersonalProjects/dotfiles/init.vim"

# Zsh
alias zshrc='vi ~/PersonalProjects/dotfiles/zshrc'
alias szh='source ~/PersonalProjects/dotfiles/zshrc'

# Tmux 
alias tma='tmux attach -t'
alias tmn='tmux new -s'
alias tmuxconf='vi ~/PersonalProjects/dotfiles/tmux.conf'

# SSH
alias sshconf='vi ~/PersonalProjects/dotfiles/sshconfig'

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
alias gitconf='vi ~/PersonalProjects/dotfiles/gitconfig'
alias lg='lazygit'

# Projects
## Work
alias ui='cd ~/Projects/ui'
alias jhs='cd ~/Projects/joint-hub-scripts'
alias pservice='cd ~/Projects/project-service'
alias es='cd ~/Projects/red-models'
alias infra='cd ~/Projects/infra-bootstrap'

## Personal
alias pp='cd ~/PersonalProjects'
alias ep='cd ~/ExternalProjects'
alias df='cd ~/PersonalProjects/dotfiles'
alias gopro='cd /Volumes/Go\ Pro/DCIM/100GOPRO && rm -rf *.THM'
alias art='cd ~/PersonalProjects/generative'
alias opf='cd ~/PersonalProjects/onepointfive'
alias add_rule='python ~/PersonalProjects/spit/add_rule.py'
alias rules='python ~/PersonalProjects/spit/read_rules.py'
alias draft='vi ~/PersonalProjects/draft.md'
alias aoc='cd ~/PersonalProjects/aoc'
alias bxyz='cd ~/PersonalProjects/behlock.xyz'
alias ccg='cd ~/PersonalProjects/collective-creation-games'
alias resume='cd ~/PersonalProjects/resume'

## Python
alias py='python'

## JS
alias prd='pnpm run dev'

## Elm
alias ys='npm run clear-cache && PARCEL_ELM_NO_DEBUG=true npm start'
alias yf='npm run format'
alias yr='npm run review --fix'

## Infra
alias k='kubectl'
alias tf='terraform'

## Misc
alias weather='curl wttr.in'
alias ytdl='yt-dlp -x -f bestaudio'

##########
# FUNCTIONS
##########

# [f]uzzy check[o]ut
fo() {
  git branch --no-color --sort=-committerdate --format='%(refname:short)' | fzf --header 'git checkout' | xargs git checkout
}

mkdircd() {
  mkdir -p $1 && cd $1
}

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

#########
# PROMPT
#########

setopt prompt_subst

git_prompt_info() {
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
local promptnormal="φ %{$reset_color%}"
local promptjobs="%{$fg_bold[red]%}φ %{$reset_color%}"

PROMPT='${dir_info}$(git_prompt_info) %(1j.$promptjobs.$promptnormal)'

########
# ENV
########

# Set default editor to vim
export EDITOR="nvim"
export GIT_EDITOR="nvim"

# Dirs and stuff
export PERSONAL_PROJECTS="~/PersonalProjects"
export DOTFILES="$PERSONAL_PROJECTS/dotfiles"
export TMUX_CONFIG="$DOTFILES/tmux.conf"

# Reduce delay for key combinations in order to change to vi mode faster
export KEYTIMEOUT=1

# RED: PYPI 
export PYPI_USER="wbehlock"

# Set python version to pyenv one
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add poetry
poetry config virtualenvs.in-project true

# Node Version Manager (NVM)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Chruby 
source /usr/local/share/chruby/chruby.sh

# Set LATEX path
export PATH="/usr/local/texlive/2022/bin/universal-darwin/:$PATH"

# FZF
# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
else
  # fzf via local installation
  if [ -e ~/.fzf ]; then
    source ~/.fzf/shell/key-bindings.zsh
    source ~/.fzf/shell/completion.zsh
    if [[ ! "$PATH" == *$HOME.fzf/bin* ]]; then
      export PATH="$PATH:$HOME/.fzf/bin"
    fi
  fi
fi

if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Created by `pipx` on 2022-11-06 19:23:52
export PATH="$PATH:/Users/wbehlock/.local/bin"

# pnpm
export PNPM_HOME="/Users/wbehlock/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# nix direnv
eval "$(direnv hook zsh)"
