# note: do not split lines

if type docker > /dev/null; then
  function docker {
    case $1 in
      'ls')
        if [[ -z $2 ]]; then
          command docker container ls --all --format 'table {{.Names}}\t{{.Image}}\t{{.State}}\t{{.Status}}'
        else
          command docker container ls "${@:2}"
        fi
        ;;
      'sh')
        if [[ -z $3 ]]; then
          command docker exec --interactive --tty $2 bash
        elif [[ $3 == 'root' ]]; then
          if [[ -z $4 ]]; then
            command docker exec --interactive --tty --user $3 $2 bash
          else
            command docker exec --user $3 $2 bash -l -c "${(j: :)@:4}"
          fi
        else
          command docker exec $2 bash -l -c "${(j: :)@:3}"
        fi
        ;;
      *)
        command docker "$@"
        ;;
    esac
  }
fi
