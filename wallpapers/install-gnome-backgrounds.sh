#!/bin/bash

readonly ROOT_UID=0
readonly MAX_DELAY=20 # max delay for user to enter root password

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKGROUND_DIR="/usr/share/backgrounds"
PROPERTIES_DIR="/usr/share/gnome-background-properties"

WALLPAPER_NAME='Vimix'

#COLORS
CDEF=" \033[0m"                               # default color
CCIN=" \033[0;36m"                            # info color
CGSC=" \033[0;32m"                            # success color
CRER=" \033[0;31m"                            # error color
CWAR=" \033[0;33m"                            # waring color
b_CDEF=" \033[1;37m"                          # bold default color
b_CCIN=" \033[1;36m"                          # bold info color
b_CGSC=" \033[1;32m"                          # bold success color
b_CRER=" \033[1;31m"                          # bold error color
b_CWAR=" \033[1;33m"                          # bold warning color

# echo like ...  with  flag type  and display message  colors
prompt () {
  case ${1} in
    "-s"|"--success")
      echo -e "${b_CGSC}${@/-s/}${CDEF}";;    # print success message
    "-e"|"--error")
      echo -e "${b_CRER}${@/-e/}${CDEF}";;    # print error message
    "-w"|"--warning")
      echo -e "${b_CWAR}${@/-w/}${CDEF}";;    # print warning message
    "-i"|"--info")
      echo -e "${b_CCIN}${@/-i/}${CDEF}";;    # print info message
    *)
    echo -e "$@"
    ;;
  esac
}

usage() {
  cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -u, --uninstall         Uninstall wallpappers
  -h, --help              Show help
EOF
}

install() {
  prompt -i "\n * Install ${WALLPAPER_NAME} wallpapers in ${BACKGROUND_DIR}... "

  [[ -d ${BACKGROUND_DIR}/${WALLPAPER_NAME} ]] && rm -rf ${BACKGROUND_DIR}/${WALLPAPER_NAME}
  [[ -f ${PROPERTIES_DIR}/${WALLPAPER_NAME}.xml ]] && rm -rf ${PROPERTIES_DIR}/${WALLPAPER_NAME}.xml

  mkdir -p ${BACKGROUND_DIR}/${WALLPAPER_NAME}

  cp -a --no-preserve=ownership ${REPO_DIR}/${WALLPAPER_NAME}*.png ${BACKGROUND_DIR}/${WALLPAPER_NAME}
  cp -a --no-preserve=ownership ${REPO_DIR}/${WALLPAPER_NAME}-timed.xml ${BACKGROUND_DIR}/${WALLPAPER_NAME}
  cp -a --no-preserve=ownership ${REPO_DIR}/${WALLPAPER_NAME}.xml ${PROPERTIES_DIR}
}

uninstall() {
  prompt -i "\n * Uninstall ${WALLPAPER_NAME}... "
  [[ -d ${BACKGROUND_DIR}/${WALLPAPER_NAME} ]] && rm -rf ${BACKGROUND_DIR}/${WALLPAPER_NAME}
  [[ -f ${PROPERTIES_DIR}/${WALLPAPER_NAME}.xml ]] && rm -rf ${PROPERTIES_DIR}/${WALLPAPER_NAME}.xml
}

while [[ $# -gt 0 ]]; do
  case "${1}" in
    -u|--uninstall)
      uninstall='true'
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      prompt -e "ERROR: Unrecognized installation option '$1'."
      prompt -i "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

if [[ $UID -ne $ROOT_UID ]];  then
  echo
  prompt -e "ERROR: Need root access! please run this script with sudo."
  echo
  exit 1
fi

echo
if [[ "${uninstall}" != 'true' ]]; then
  install
else
  uninstall
fi
echo

prompt -s "Finished!\n"
