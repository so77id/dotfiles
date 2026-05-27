# Homebrew (Apple Silicon — /opt/homebrew)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Powerlevel10k instant prompt — debe ir lo más arriba posible
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Resto de la config vive en .zshrc.local
source ~/.dotfiles/zsh/.zshrc.local
