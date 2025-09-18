if type pkgutil > /dev/null; then
  function xcode-print-versions {
    if pkgutil --pkgs=com.apple.pkg.Xcode > /dev/null 2>&1; then
      echo Xcode: $(pkgutil --pkg-info=com.apple.pkg.Xcode | awk '/version:/ {print $2}')
    else
      echo Xcode: not installed
    fi

    if pkgutil --pkgs=com.apple.pkg.CLTools_Executables > /dev/null 2>&1; then
      echo CommandLineTools: $(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | awk '/version:/ {print $2}')
    else
      echo CommandLineTools: not installed
    fi
  }
fi
