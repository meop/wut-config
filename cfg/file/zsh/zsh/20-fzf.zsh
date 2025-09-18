if [[ -f "${HOME}/.fzf/theme.zsh" ]]; then
  . "${HOME}/.fzf/theme.zsh"
fi

if type fzf > /dev/null; then
  . <(fzf --zsh)
fi
