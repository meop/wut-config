# note: do not split lines

if type proot-distro > /dev/null; then
  function proot-distro {
    case $1 in
      'sh')
        if [[ -z $3 ]]; then
          command proot-distro login --bind '/sdcard:/sdcard' --bind '/storage:/storage' --bind '/system:/system' --bind '/vendor:/vendor' --isolated --termux-home --user ${USER} $2
        else
          command proot-distro login --bind '/sdcard:/sdcard' --bind '/storage:/storage' --bind '/system:/system' --bind '/vendor:/vendor' --isolated --termux-home --user $3 $2
        fi
        ;;
      *)
        command proot-distro "$@"
        ;;
    esac
  }
fi
