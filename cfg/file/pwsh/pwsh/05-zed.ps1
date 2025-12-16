if (Get-Command zeditor -ErrorAction Ignore) {
  Set-Alias zed 'zeditor'
}
if (Get-Command zed-cli -ErrorAction Ignore) {
  Set-Alias zed 'zed-cli'
}
