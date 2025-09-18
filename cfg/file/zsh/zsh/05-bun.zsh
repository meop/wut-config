if [[ -d "${HOME}/.bun" ]]; then
  export BUN_INSTALL="${HOME}/.bun"
  export PATH="${BUN_INSTALL}/bin:${PATH}"
fi

[[ -f "${BUN_INSTALL}/_bun" ]] && . "${BUN_INSTALL}/_bun"
