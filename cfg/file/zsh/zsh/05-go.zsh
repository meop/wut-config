if type go > /dev/null; then
  export PATH="$(go env GOBIN):$(go env GOPATH)/bin:${PATH}"
fi
