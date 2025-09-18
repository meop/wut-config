if (Get-Command vim -ErrorAction Ignore) {
  $env:EDITOR = 'vim'
  $env:VISUAL = 'vim'
}
