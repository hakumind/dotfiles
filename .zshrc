# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ===== oh-my-zsh 基本設定 =====
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"   # プロンプトテーマ

plugins=(git z)  # 必要なプラグインだけ

source $ZSH/oh-my-zsh.sh

# ===== zoxide (ディレクトリジャンプ) =====
eval "$(zoxide init zsh)"

# ===== fzf (ファイル検索) =====
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ===== エイリアス例 =====
alias ll='ls -lah'          # 見やすい ls
alias ..='cd ..'             # 一つ上のディレクトリへ
alias sortdesk='~/sort_desktop.sh'  # デスクトップ整理スクリプト
alias amazon='open -a "Google Chrome" "https://www.amazon.co.jp/"'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
