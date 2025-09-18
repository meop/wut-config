# https://github.com/folke/tokyonight.nvim/blob/main/extras/iterm/tokyonight_moon.itermcolors
function () {
  local yn=''
  if [[ -d /Applications/iTerm.app ]]; then
    if [[ $YES ]]; then
      yn='y'
    else
      read 'yn?? setup iterm - download theme (user) [y, [n]]: '
    fi
    if [[ $yn != 'n' ]]; then
      local outputDir="${HOME}/Downloads"
      if [[ ! -d "$outputDir" ]]; then
        outputDir="${HOME}"
      fi
      local url='https://raw.githubusercontent.com/folke/tokyonight.nvim/HEAD/extras/iterm/tokyonight_moon.itermcolors'
      opPrintMaybeRunCmd curl --fail-with-body --location --no-progress-meter --output-dir "${outputDir}" --remote-name --url "${url}"
    fi
  else
    echo 'iterm is not installed'
  fi
}
