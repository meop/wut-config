if [[ -d "/Users/${USER}/Library/Android/sdk" ]]; then
  export ANDROID_HOME="/Users/${USER}/Library/Android/sdk"

  export PATH="${ANDROID_HOME}/platform-tools:${PATH}"
  export PATH="${ANDROID_HOME}/tools:${PATH}"
fi
