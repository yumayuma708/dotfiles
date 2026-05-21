# path

#z command
. ~/z/z.sh

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="apple"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-completions
  zsh-autosuggestions
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# peco
function peco-select-history() {
local tac
if which tac > /dev/null; then
tac="tac"
else
tac="tail -r"
fi
BUFFER=$(\history -n 1 | \
eval $tac | \
peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history


# bun completions
[ -s "/Users/yuma/.bun/_bun" ] && source "/Users/yuma/.bun/_bun"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="$PATH:$(npm config get prefix)/bin"
export PATH="$PATH:$(npm config get prefix)/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$(brew --prefix postgresql@14)/bin:$PATH"

# ===== 略語展開（fish の abbr 相当） =====
# スペースを押した瞬間に略語を実コマンドへ展開する
typeset -A ZSH_ABBR
ZSH_ABBR=(
  g       'git'
  gi      'git'
  gs      'git switch'
  gsw     'git switch'
  gsm     'git switch main'
  gsd     'git switch develop'
  gmm     'git merge origin/main'
  gmd     'git merge origin/develop'
  'ga.'   'git add .'
  gf      'git fetch'
  gfe     'git fetch'
  gpl     'git pull'
  gba     'git branch -a'
  gpm     'git push -u origin main'
)
_zsh_abbr_expand() {
  local word=${LBUFFER##* }
  local expansion=${ZSH_ABBR[$word]}
  if [[ -n $expansion ]]; then
    LBUFFER=${LBUFFER%$word}$expansion
  fi
  zle self-insert  # 押されたキー（スペース）をそのまま入力
}
_zsh_abbr_expand_enter() {
  local word=${LBUFFER##* }
  local expansion=${ZSH_ABBR[$word]}
  if [[ -n $expansion ]]; then
    LBUFFER=${LBUFFER%$word}$expansion
  fi
  zle accept-line
}
zle -N _zsh_abbr_expand
zle -N _zsh_abbr_expand_enter
bindkey ' '  _zsh_abbr_expand        # スペースで展開
bindkey '^M' _zsh_abbr_expand_enter  # Enter でも展開してから実行

# ===== カスタムエイリアス（fish abbr から移植） =====

# git 基本
alias g='git'
alias gi='git'
alias gs='git switch'
alias gsw='git switch'
alias gsm='git switch main'
alias gsd='git switch develop'
alias gmm='git merge origin/main'
alias gmd='git merge origin/develop'
alias ga.='git add .'
alias gf='git fetch'
alias gfe='git fetch'
alias gpl='git pull'
alias gba='git branch -a'
alias gpm='git push -u origin main'
alias gc='git commit -m "自動変更"'

# git: 引数を取るもの（関数化）
# 使い方: gcm "コミットメッセージ"
gcm() { git commit -m "$*" }
# 使い方: gpu ブランチ名
gpu() { git push -u origin "$1" }
# 使い方: gs- ブランチ名末尾（git switch - で直前ブランチへ）
alias gs-='git switch -'
# 使い方: gm ブランチ名（git merge origin/<branch>）
gm() { git merge "origin/$1" }

# git init 一括（first commit まで）
gin() {
  git init
  git branch -M main
  git add .
  git commit -m "first commit"
  local clip="$(pbpaste)"
  if [[ "$clip" == git@* ]]; then
    git remote add origin "$clip"
    git push -u origin main
  else
    echo "リモートURLを手動で設定してください: git remote add origin <URL>"
  fi
}

# クリップボード連携
# 使い方: echo hello | pbcopy の代わりに cpy（パイプで受ける）
alias cpy='pbcopy'
# 使い方: clip ファイル名 → ファイル内容をクリップボードへ
clip() { cat "$1" | pbcopy }

# 連続した .. で上に登る（.... で2つ上、..... で3つ上）
..() { cd .. }
...() { cd ../.. }
....() { cd ../../.. }
.....() { cd ../../../.. }

# ===== config.fish から移植 =====
# 注意: fish 用の `source ~/.config/fish/configs/*.fish` は fish 構文のため
# zsh からは読み込めません。必要な PATH 設定のみ zsh 構文で書き直しています。

# Homebrew
if [ -f "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Flutter
export PATH="/Users/yuma/programming/Flutter/flutter/bin:$PATH"

# ~/.local/bin
export PATH="$HOME/.local/bin:$PATH"

# pyenv
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# fvm (Flutter Version Management)
export PATH="$HOME/fvm/default/bin:$PATH"

# Google Cloud SDK
if [ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
fi
if [ -f "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc" ]; then
  source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
fi
