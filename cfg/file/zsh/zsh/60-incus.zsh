# note: do not split lines

if type incus > /dev/null; then
  function incus {
    case $1 in
      'ls')
        if [[ -z $2 ]]; then
          command incus ls -c nts4
        else
          command incus ls "${@:2}"
        fi
        ;;
      'sh')
        if [[ -z $3 ]]; then
          command incus exec $2 -- su -l ${USER}
        elif [[ $3 == 'root' ]]; then
          if [[ -z $4 ]]; then
            command incus exec $2 -- su -l $3
          else
            command incus exec $2 -- su -l $3 bash -l -c "${(j: :)@:4}"
          fi
        else
          command incus exec $2 -- su -l ${USER} bash -l -c "${(j: :)@:3}"
        fi
        ;;
      'xhost')
        xhost si:localuser:${USER} > /dev/null 2>&1
        ;;
      *)
        command incus "$@"
        ;;
    esac
  }
fi
