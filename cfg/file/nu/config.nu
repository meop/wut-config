$env.config.show_banner = false
$env.config.history.sync_on_enter = false
$env.config.rm.always_trash = false

const NU_VENDOR_DATA_DIR = (
  [$nu.data-dir, 'vendor', 'autoload'] | path join
)

mkdir $NU_VENDOR_DATA_DIR

## prompt
starship init nu | save -f (
  [$NU_VENDOR_DATA_DIR, 'starship.nu'] | path join
)

## jump
zoxide init nushell | save -f (
  [$NU_VENDOR_DATA_DIR, 'zoxide.nu'] | path join
)

## aliases
alias bd = cd -
alias ud = cd ..
alias md = mkdir
alias rd = rmdir

## functions
def path-expand --wrapped [...args] {
  $args | each {
    |a| if ($a | str starts-with '~') {
      $a | path expand
    } else {
      $a
    }
  }
}

def v --wrapped [...args] {
  ^($env.VISUAL) ...(path-expand ...$args)
}
