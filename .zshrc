# Automatic installation
if [[ ! -e $HOME/.zsh ]] {
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
    git clone https://github.com/skywind3000/z.lua.git "$HOME/.zsh/z.lua"
}
setopt IGNORE_EOF # 关闭 control + D 关闭 shell 
source $HOME/.profile

# emoji
setopt COMBINING_CHARS

# upgrade zsh plugin
alias upgrade_zsh_plugin="ls $HOME/.zsh/ --color=none | xargs -I{} git -C $HOME/.zsh/{} pull"

# python
export PYTHONDONTWRITEBYTECODE=1

# awesome alias
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    eval "$(dircolors -b)"
else # OS X `ls`
    colorflag="-G"
    LS_COLORS="Gxfxcxdxbxegedabagacad"
fi
alias l="ls"
alias ll="ls -alhF"
alias ls="ls ${colorflag}"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias how="tldr"


# theme
fpath+=$HOME/.zsh/pure
autoload -Uz promptinit
promptinit

# change the color
zstyle ':prompt:pure:git:branch' color magenta
zstyle ':prompt:pure:host' color green
zstyle ':prompt:pure:user' color green

# turn on git stash status
zstyle :prompt:pure:git:stash show yes
# use pure theme
prompt pure

# 历史记录去重
setopt HIST_IGNORE_DUPS

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# z.lua 
eval "$(lua ~/.zsh/z.lua/z.lua  --init zsh)"

# syntax-highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
