#! /usr/bin/env bash

ROOT_UID=0

# Destination directory
if [ "$UID" -eq "$ROOT_UID" ]; then
  DEST_DIR="/usr/share/themes"
else
  DEST_DIR="$HOME/.themes"
fi

REO_DIR=$(cd $(dirname $0) && pwd)
SRC_DIR=${REO_DIR}/src

SASSC_OPT="-M -t expanded"

THEME_NAME=vimix
COLOR_VARIANTS=('' '-light' '-dark')
SIZE_VARIANTS=('' '-laptop')
THEME_VARIANTS=('' '-doder' '-beryl' '-ruby' '-amethyst')

if [[ "$(command -v gnome-shell)" ]]; then
  SHELL_VERSION="$(gnome-shell --version | cut -d ' ' -f 3 | cut -d . -f -1)"
  if [[ "${SHELL_VERSION:-}" -ge "40" ]]; then
    GS_VERSION="new"
  else
    GS_VERSION="old"
  fi
  else
    echo "'gnome-shell' not found, using styles for last gnome-shell version available."
    GS_VERSION="new"
fi

usage() {
  printf "%s\n" "Usage: $0 [OPTIONS...]"
  printf "\n%s\n" "OPTIONS:"
  printf "  %-25s%s\n" "-d, --dest DIR" "Specify theme destination directory (Default: ${DEST_DIR})"
  printf "  %-25s%s\n" "-n, --name NAME" "Specify theme name (Default: ${THEME_NAME})"
  printf "  %-25s%s\n" "-a, --all VARIANTS" "Install all theme variant(s)"
  printf "  %-25s%s\n" "-c, --color VARIANTS" "Specify theme color variant(s) [standard|light|dark] (Default: All variants)"
  printf "  %-25s%s\n" "-t, --theme VARIANTS" "Specify hue theme variant(s) [standard|doder|beryl|ruby|amethyst] (Default: doder)"
  printf "  %-25s%s\n" "-s, --size VARIANTS" "Specify theme size variant(s) [standard|laptop] (Default: All variants)"
  printf "  %-25s%s\n" "-f, --flat" "Specify theme with flat and normal titlebutton style"
  printf "  %-25s%s\n" "-g, --grey" "Use grey titlebuttons in standard variants"
  printf "  %-25s%s\n" "-h, --help" "Show this help"
}

install() {
  local dest=${1}
  local name=${2}
  local color=${3}
  local size=${4}

  # Appends a dash if the variables are not empty
  if [[ "$5" != "-t" ]]; then
    local -r theme="$5"
  fi

  [[ ${color} == '-dark' ]] && local ELSE_DARK=${color}
  [[ ${color} == '-light' ]] && local ELSE_LIGHT=${color}

  local THEME_DIR=${dest}/${name}${color}${size}${theme}

  [[ -d ${THEME_DIR} ]] && rm -rf ${THEME_DIR}

  echo "Installing '${THEME_DIR}'..."

  #  Copy LICENSE
  mkdir -p                                                                              ${THEME_DIR}
  cp -r ${REO_DIR}/LICENSE                                                              ${THEME_DIR}
  cp -r ${REO_DIR}/AUTHORS                                                              ${THEME_DIR}

  #  Install index.theme files
  echo "[Desktop Entry]"                                                             >> ${THEME_DIR}/index.theme
  echo "Type=X-GNOME-Metatheme"                                                      >> ${THEME_DIR}/index.theme
  echo "Name=${name}${color}${size}${theme}"                                         >> ${THEME_DIR}/index.theme
  echo "Comment=An Clean Gtk+ theme based on Material Design"                        >> ${THEME_DIR}/index.theme
  echo "Encoding=UTF-8"                                                              >> ${THEME_DIR}/index.theme
  echo ""                                                                            >> ${THEME_DIR}/index.theme
  echo "[X-GNOME-Metatheme]"                                                         >> ${THEME_DIR}/index.theme
  echo "GtkTheme=${name}${color}${size}${theme}"                                     >> ${THEME_DIR}/index.theme
  echo "MetacityTheme=${name}${color}${size}${theme}"                                >> ${THEME_DIR}/index.theme
  echo "IconTheme=Adwaita"                                                           >> ${THEME_DIR}/index.theme
  echo "CursorTheme=Adwaita"                                                         >> ${THEME_DIR}/index.theme
  echo "ButtonLayout=menu:minimize,maximize,close"                                   >> ${THEME_DIR}/index.theme

  #  Install gtk2 theme
  mkdir -p                                                                              ${THEME_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/common/*.rc                                                  ${THEME_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/assets/vimix${theme}/assets${ELSE_DARK}                      ${THEME_DIR}/gtk-2.0/assets

  [[ ${color} == '' ]] && [[ ${theme} == '' ]] && \
  cp -r ${SRC_DIR}/gtk-2.0/assets/vimix/assets-dark/pathbar_button_active.png           ${THEME_DIR}/gtk-2.0/assets && \
  cp -r ${SRC_DIR}/gtk-2.0/assets/vimix/assets-dark/pathbar_button_prelight.png         ${THEME_DIR}/gtk-2.0/assets

  cp -r ${SRC_DIR}/gtk-2.0/gtkrc${color}${theme}                                        ${THEME_DIR}/gtk-2.0/gtkrc

  #  Install gtk3 theme
  mkdir -p                                                                              ${THEME_DIR}/gtk-3.0/assets
  cp -r ${SRC_DIR}/gtk/assets/assets${theme}/*.png                                      ${THEME_DIR}/gtk-3.0/assets

  if [[ ${flat} != 'true' ]]; then
    if [[ ${grey} == 'true' ]]; then
      cp -r ${SRC_DIR}/gtk/assets/window-assets-contrast                                ${THEME_DIR}/gtk-3.0/assets/window-assets
    else
      cp -r ${SRC_DIR}/gtk/assets/window-assets                                         ${THEME_DIR}/gtk-3.0/assets
    fi
  fi

  cp -r ${SRC_DIR}/gtk/assets/scalable                                                  ${THEME_DIR}/gtk-3.0/assets

  if [[ ${flat} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/gtk/3.0/gtk${color}${size}${theme}.scss                 ${THEME_DIR}/gtk-3.0/gtk.css

    [[ ${color} != '-dark' ]] && \
    sassc $SASSC_OPT ${SRC_DIR}/gtk/3.0/gtk-dark${size}${theme}.scss                    ${THEME_DIR}/gtk-3.0/gtk-dark.css
  else
    cp -r ${SRC_DIR}/gtk/3.0/gtk${color}${size}${theme}.css                             ${THEME_DIR}/gtk-3.0/gtk.css

    [[ ${color} != '-dark' ]] && \
    cp -r ${SRC_DIR}/gtk/3.0/gtk-dark${size}${theme}.css                                ${THEME_DIR}/gtk-3.0/gtk-dark.css
  fi

  cp -r ${SRC_DIR}/gtk/assets/thumbnails/thumbnail${color}${theme}.png                  ${THEME_DIR}/gtk-3.0/thumbnail.png

  #  Install gtk4 theme
  mkdir -p                                                                              ${THEME_DIR}/gtk-4.0/assets
  cp -r ${SRC_DIR}/gtk/assets/assets${theme}/*.png                                      ${THEME_DIR}/gtk-4.0/assets

  if [[ ${flat} != 'true' ]]; then
    if [[ ${grey} == 'true' ]]; then
      cp -r ${SRC_DIR}/gtk/assets/window-assets-contrast                                ${THEME_DIR}/gtk-4.0/assets/window-assets
    else
      cp -r ${SRC_DIR}/gtk/assets/window-assets                                         ${THEME_DIR}/gtk-4.0/assets
    fi
  fi

  cp -r ${SRC_DIR}/gtk/assets/scalable                                                  ${THEME_DIR}/gtk-4.0/assets

  if [[ ${flat} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/gtk/4.0/gtk${color}${size}${theme}.scss                 ${THEME_DIR}/gtk-4.0/gtk.css

    [[ ${color} != '-dark' ]] && \
    sassc $SASSC_OPT ${SRC_DIR}/gtk/4.0/gtk-dark${size}${theme}.scss                    ${THEME_DIR}/gtk-4.0/gtk-dark.css
  else
    cp -r ${SRC_DIR}/gtk/4.0/gtk${color}${size}${theme}.css                             ${THEME_DIR}/gtk-4.0/gtk.css

    [[ ${color} != '-dark' ]] && \
    cp -r ${SRC_DIR}/gtk/4.0/gtk-dark${size}${theme}.css                                ${THEME_DIR}/gtk-4.0/gtk-dark.css
  fi

  cp -r ${SRC_DIR}/gtk/assets/thumbnails/thumbnail${color}${theme}.png                  ${THEME_DIR}/gtk-4.0/thumbnail.png

  #  Install gnome-shell theme
  mkdir -p                                                                              ${THEME_DIR}/gnome-shell
  cp -r ${SRC_DIR}/gnome-shell/pad-osd.css                                              ${THEME_DIR}/gnome-shell
  cp -r ${SRC_DIR}/gnome-shell/common-assets                                            ${THEME_DIR}/gnome-shell/assets
  cp -r ${SRC_DIR}/gnome-shell/assets${ELSE_DARK}/*.svg                                 ${THEME_DIR}/gnome-shell/assets
  cp -r ${SRC_DIR}/gnome-shell/color-assets/checkbox${theme}.svg                        ${THEME_DIR}/gnome-shell/assets/checkbox.svg
  cp -r ${SRC_DIR}/gnome-shell/color-assets/more-results${theme}.svg                    ${THEME_DIR}/gnome-shell/assets/more-results.svg
  cp -r ${SRC_DIR}/gnome-shell/color-assets/toggle-on${theme}.svg                       ${THEME_DIR}/gnome-shell/assets/toggle-on.svg

  if [[ "${GS_VERSION:-}" == 'new' ]]; then
    cp -r ${SRC_DIR}/gnome-shell/shell-40-0/gnome-shell${color}${size}${theme}.css      ${THEME_DIR}/gnome-shell/gnome-shell.css
  else
    cp -r ${SRC_DIR}/gnome-shell/shell-3-28/gnome-shell${color}${size}${theme}.css      ${THEME_DIR}/gnome-shell/gnome-shell.css
  fi

  cd ${THEME_DIR}/gnome-shell
  ln -s assets/no-events.svg no-events.svg
  ln -s assets/process-working.svg process-working.svg
  ln -s assets/no-notifications.svg no-notifications.svg

  #  Install metacity theme
  mkdir -p                                                                              ${THEME_DIR}/metacity-1
  cp -r ${SRC_DIR}/metacity-1/assets/*.png                                              ${THEME_DIR}/metacity-1
  cp -r ${SRC_DIR}/metacity-1/metacity-theme-3.xml                                      ${THEME_DIR}/metacity-1
  cp -r ${SRC_DIR}/metacity-1/metacity-theme-1${color}${theme}.xml                      ${THEME_DIR}/metacity-1/metacity-theme-1.xml
  cp -r ${SRC_DIR}/metacity-1/thumbnail${color}.png                                     ${THEME_DIR}/metacity-1/thumbnail.png

  cd ${THEME_DIR}/metacity-1 && ln -s metacity-theme-1.xml metacity-theme-2.xml

  #  Install xfwm4 theme
  mkdir -p                                                                              ${THEME_DIR}/xfwm4
  cp -r ${SRC_DIR}/xfwm4/themerc${color}                                                ${THEME_DIR}/xfwm4/themerc

  [[ ${grey} == '' ]] && \
  cp -r ${SRC_DIR}/xfwm4/assets${color}${theme}/*.png                                   ${THEME_DIR}/xfwm4

  [[ ${theme} == '' && ${grey} == 'true' ]] && \
  cp -r ${SRC_DIR}/xfwm4/assets${color}-contrast/*.png                                  ${THEME_DIR}/xfwm4

  #  Install unity theme
  cp -r ${SRC_DIR}/unity                                                                ${THEME_DIR}

  mkdir -p                                                                              ${THEME_DIR}/plank
  cp -r ${SRC_DIR}/plank/dock${ELSE_LIGHT}.theme                                        ${THEME_DIR}/plank/dock.theme

  #  Install cinnamon theme
  mkdir -p                                                                              ${THEME_DIR}/cinnamon
  cp -r ${SRC_DIR}/cinnamon/cinnamon${ELSE_DARK}${theme}.css                            ${THEME_DIR}/cinnamon/cinnamon.css
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/common-assets                                ${THEME_DIR}/cinnamon/assets
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/checkbox/*.svg            ${THEME_DIR}/cinnamon/assets/checkbox
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/menu/*.svg                ${THEME_DIR}/cinnamon/assets/menu
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/misc/*.svg                ${THEME_DIR}/cinnamon/assets/misc
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/switch/*.svg              ${THEME_DIR}/cinnamon/assets/switch
  cp -r ${SRC_DIR}/cinnamon/thumbnail${ELSE_DARK}${theme}.png                           ${THEME_DIR}/cinnamon/thumbnail.png
}

#  Check command avalibility
function has_command() {
  command -v $1 > /dev/null
}

#  Install needed packages
install_package() {
  if [ ! "$(which sassc 2> /dev/null)" ]; then
    echo sassc needs to be installed to generate the css.
    if has_command zypper; then
      sudo zypper in sassc
    elif has_command apt-get; then
      sudo apt-get install sassc
    elif has_command dnf; then
      sudo dnf install sassc
    elif has_command dnf; then
      sudo dnf install sassc
    elif has_command pacman; then
      sudo pacman -S --noconfirm sassc
    fi
  fi
}

#  Install theme
install_theme() {
  for color in "${colors[@]-${COLOR_VARIANTS[@]}}"; do
    for size in "${sizes[@]-${SIZE_VARIANTS[@]}}"; do
      for theme in "${themes[@]:--doder}"; do
        install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}" "${theme}"
      done
    done
  done
}

install_flat() {
  cd ${SRC_DIR}/gtk/sass
  cp -an _tweaks.scss _tweaks.scss.bak
  sed -i "/\$titlebutton:/s/default/flat/" _tweaks.scss
  echo -e "Install flat version ..."
}

restore_flat() {
  cd ${SRC_DIR}/gtk/sass
  [[ -f _tweaks.scss.bak ]] && rm -rf _tweaks.scss
  mv _tweaks.scss.bak _tweaks.scss
  echo -e "Restore _tweaks.scss file ..."
}

while [ $# -gt 0 ]; do
  case "${1}" in
    -d|--dest)
      dest="${2}"
      if [[ ! -d "${dest}" ]]; then
        echo "ERROR: Destination directory does not exist."
        exit 1
      fi
      shift 2
      ;;
    -n|--name)
      name="${2}"
      shift 2
      ;;
    -a|--all)
      themes=("${THEME_VARIANTS[@]}")
      shift 1
      ;;
    -f|--flat)
      flat="true"
      shift 1
      ;;
    -g|--grey)
      grey="true"
      shift 1
      ;;
    -t|--theme)
      shift
      for theme in "${@}"; do
        case "${theme}" in
          standard)
            themes+=("${THEME_VARIANTS[0]}")
            shift 1
            ;;
          doder)
            themes+=("${THEME_VARIANTS[1]}")
            shift 1
            ;;
          beryl)
            themes+=("${THEME_VARIANTS[2]}")
            shift 1
            ;;
          ruby)
            themes+=("${THEME_VARIANTS[3]}")
            shift 1
            ;;
          amethyst)
            themes+=("${THEME_VARIANTS[4]}")
            shift 1
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -c|--color)
      shift
      for color in "${@}"; do
        case "${color}" in
          standard)
            colors+=("${COLOR_VARIANTS[0]}")
            shift 1
            ;;
          light)
            colors+=("${COLOR_VARIANTS[1]}")
            shift 1
            ;;
          dark)
            colors+=("${COLOR_VARIANTS[2]}")
            shift 1
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -s|--size)
      shift
      for size in "${@}"; do
        case "${size}" in
          standard)
            sizes+=("${SIZE_VARIANTS[0]}")
            shift 1
            ;;
          laptop)
            sizes+=("${SIZE_VARIANTS[1]}")
            shift 1
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized color variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
      -c|--color)
        shift
        for color in "${@}"; do
          case "${color}" in
            standard)
              colors+=("${COLOR_VARIANTS[0]}")
              shift 1
              ;;
            light)
              colors+=("${COLOR_VARIANTS[1]}")
              shift 1
              ;;
            dark)
              colors+=("${COLOR_VARIANTS[2]}")
              shift 1
              ;;
            -*|--*)
              break
              ;;
            *)
              echo "ERROR: Unrecognized color variant '$1'."
              echo "Try '$0 --help' for more information."
              exit 1
              ;;
          esac
        done
        ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unrecognized installation option '$1'."
      echo "Try '$0 --help' for more information."
      exit 1
      ;;
  esac
done

if [[ "${flat}" == 'true' ]]; then
  install_package && install_flat && install_theme && restore_flat
fi

if [[ "${flat}" != 'true' ]]; then
  install_theme
fi

echo
echo Done.
