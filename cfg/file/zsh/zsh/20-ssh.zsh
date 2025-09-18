if type ssh-add > /dev/null; then
  if [[ -f "${HOME}/.ssh/id_rsa" ]]; then
    ssh-add "${HOME}/.ssh/id_rsa" > /dev/null 2>&1
  fi
  if [[ -f "${HOME}/.ssh/id_ed25519" ]]; then
    ssh-add "${HOME}/.ssh/id_ed25519" > /dev/null 2>&1
  fi
fi
