##--------------##
## zshオプション##
##--------------##

# 補完機能
autoload -Uz compinit
compinit

# tabで候補を切り替える
zstyle ':completion:*:default' menu select=2

# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# 補完候補にも色を適用
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

# 入力が右端まで来たらRPROMPTを消す
setopt transient_rprompt

# 間違い指摘(もしかして:)
setopt correct

# 他のターミナルとヒストリー共有
setopt share_history

# ヒストリーに重複を表示しない
setopt histignorealldups

# 直前と同じコマンドをヒストリーに追加しない
setopt hist_ignore_dups

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# ディレクトリ名のみでcd可能にする
setopt auto_cd

# 自動でpushd実行
setopt auto_pushd

DIRSTACKSIZE=100

# ディレクトリスタックから重複を削除
setopt pushd_ignore_dups

# バックグラウンドジョブが終了したら知らせる
setopt no_tify

##-----------##
## プロンプト##
##-----------##

# プロンプトを表示する際に最初に変数展開する
setopt prompt_subst

# 色の使用
# ${fg[ ... ]} や $reset_color をロード
autoload -Uz colors
colors

# VCS (gitのステータスをプロンプト右端に表示)
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

# プロンプト
zstyle ':prezto:module:editor:info:keymap:primary' format '%B%F{blue}❯%f%b'
SEP=`echo -e "\xE2\xAE\x80"`
FONT_COL='233'

#PROMPT=" %F{038}%T%f %F{230}[%M]%f %F{206}%~ %f
# %F{155}$%f "

PROMPT="%{%F{$FONT_COL}%K{038}%}%D %T%{%k%f%}%{%F{038}%K{230}%}$SEP%{%f%k%}%{%F{$FONT_COL}%K{230}%}[%M]%{%f%k%}%{%F{230}%K{206}%}$SEP%{%k%f%}%{%K{206}%F{$FONT_COL}%}%~%{%f%k%}%F{206}$SEP%f
%(?.%F{green}.%F{red})%(?! OK ! NG )%f %F{155}$%f "
##--------##
## その他 ##
##--------##

# cd後、自動でls
# もしglsを使う場合
# function chpwd() { gls --color=auto }
# もしexaを使う場合
function chpwd() { exa --time-style=long-iso -g }

# lsに色を付ける(GNU版 ls (gls) をデフォルトに設定)
eval `gdircolors ~/.dircolors-solarized/dircolors.256dark`
# もしglsを使う場合
# alias ls='gls --color=auto' 

##------------##
## エイリアス ##
##------------##

alias chrome='open -a /Applications/'\''Google Chrome.app'\'''
alias sublime='open -a /Applications/'\''Sublime Text.app'\'''
alias globalip='curl inet-ip.info'

alias -s html=chrome
alias -s py=python
alias -s rb=ruby

# for Luxury command

echo "alias ls='exa --time-style=long-iso -g'" >> ~/.zprofile
echo "alias ll='ls --git --time-style=long-iso -gl'" >> ~/.zprofile
echo "alias la='ls --git --time-style=long-iso -agl'" >> ~/.zprofile
echo "alias l1='exa -1'" >> ~/.zprofile

source ~/.zshenv
