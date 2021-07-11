export EDITOR=vim

export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history
setopt IGNOREEOF
unsetopt PROMPT_SP

# Fuck Python2.x
alias python='python3'
alias python-config='python3-config'
alias pip='pip3'

# n
export N_PREFIX=$HOME/.n
export PATH=$N_PREFIX/bin:$PATH

# peco
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^u' peco-cdr

# starship
eval "$(starship init zsh)"

