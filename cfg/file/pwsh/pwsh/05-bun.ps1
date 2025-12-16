if (Test-Path "${HOME}\.bun") {
  $env:BUN_INSTALL = "${HOME}\.bun"
  $env:PATH = "${env:BUN_INSTALL}\bin;${env:PATH}"
}
