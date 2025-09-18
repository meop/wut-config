$env.SHELL = which nu | get path

if 'USERNAME' in $env {
  $env.USER = $env.USERNAME
}

if 'USERPROFILE' in $env {
  $env.HOME = $env.USERPROFILE
}

const NU_EXT = 'nu'
const NU_HOME_DIR = (
  [$nu.home-path, $".($NU_EXT)"] | path join | path expand
)
source (if ([$NU_HOME_DIR, $"00-vim.($NU_EXT)"] | path join | path expand | path exists) {
  [$NU_HOME_DIR, $"00-vim.($NU_EXT)"] | path join | path expand
} else {
  null
})
source (if ([$NU_HOME_DIR, $"01-nvim.($NU_EXT)"] | path join | path expand | path exists) {
  [$NU_HOME_DIR, $"01-nvim.($NU_EXT)"] | path join | path expand
} else {
  null
})
source (if ([$NU_HOME_DIR, $"70-wut.($NU_EXT)"] | path join | path expand | path exists) {
  [$NU_HOME_DIR, $"70-wut.($NU_EXT)"] | path join | path expand
} else {
  null
})
