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
SIZE_VARIANTS=('' '-compact')
THEME_VARIANTS=('-grey' '-doder' '-beryl' '-ruby' '-amethyst' '-jade')

if [[ "$(command -v gnome-shell)" ]]; then
  gnome-shell --version
  SHELL_VERSION="$(gnome-shell --version | cut -d ' ' -f 3 | cut -d . -f -1)"
  if [[ "${SHELL_VERSION:-}" -ge "46" ]]; then
    GS_VERSION="46-0"
  elif [[ "${SHELL_VERSION:-}" -ge "44" ]]; then
    GS_VERSION="44-0"
  elif [[ "${SHELL_VERSION:-}" -ge "42" ]]; then
    GS_VERSION="42-0"
  elif [[ "${SHELL_VERSION:-}" -ge "40" ]]; then
    GS_VERSION="40-0"
  else
    GS_VERSION="3-28"
  fi
else
  echo "'gnome-shell' not found, using styles for last gnome-shell version available."
  GS_VERSION="46-0"
fi

usage() {
cat << EOF
Usage: $0 [OPTION]...

OPTIONS:
  -d, --dest DIR          Specify destination directory (Default: $DEST_DIR)
  -n, --name NAME         Specify theme name (Default: $THEME_NAME)
  -t, --theme VARIANT     Specify theme color variant(s) [doder|beryl|ruby|amethyst|jade|grey|all] (Default: doder(blue))
  -c, --color VARIANT     Specify color variant(s) [standard|light|dark] (Default: All variants)
  -s, --size  VARIANT     Specify size variant [standard|compact|all] (Default: standard variant)

  -l, --libadwaita        Link installed gtk-4.0 theme to config folder for all libadwaita app use this theme

  -r, --remove,
  -u, --uninstall         Uninstall/Remove installed themes

  -tweaks, --tweaks       Specify versions for tweaks [flat|grey|mix|translucent] (only nord and dracula can not mix use with!)
                          1. flat         Flat and normal button style for windows control buttons
                          2. grey         Use grey windows control buttons in grey accent color variants
                          3. mix          Mix theme color and dark grey color for background color in darkmode variants
                          4. translucent  Translucent panel version

  -h, --help              Show help
EOF
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

  theme_tweaks

  #  Copy LICENSE
  mkdir -p                                                                              ${THEME_DIR}
  cp -r ${REO_DIR}/LICENSE                                                              ${THEME_DIR}
  cp -r ${REO_DIR}/AUTHORS                                                              ${THEME_DIR}

  #  Install index.theme files
  echo "[Desktop Entry]"                                                             >> ${THEME_DIR}/index.theme
  echo "Type=X-GNOME-Metatheme"                                                      >> ${THEME_DIR}/index.theme
  echo "Name=${name}${color}${size}${theme}"                                         >> ${THEME_DIR}/index.theme
  echo "Comment=Clean Gtk+ theme based on Material Design"                           >> ${THEME_DIR}/index.theme
  echo "Encoding=UTF-8"                                                              >> ${THEME_DIR}/index.theme
  echo ""                                                                            >> ${THEME_DIR}/index.theme
  echo "[X-GNOME-Metatheme]"                                                         >> ${THEME_DIR}/index.theme
  echo "GtkTheme=${name}${color}${size}${theme}"                                     >> ${THEME_DIR}/index.theme
  echo "MetacityTheme=${name}${color}${size}${theme}"                                >> ${THEME_DIR}/index.theme
  echo "IconTheme=${name}${theme}${color}"                                           >> ${THEME_DIR}/index.theme
  echo "CursorTheme=${name}${theme}${color}"                                         >> ${THEME_DIR}/index.theme
  echo "ButtonLayout=menu:minimize,maximize,close"                                   >> ${THEME_DIR}/index.theme

  #  Install gtk2 theme
  mkdir -p                                                                              ${THEME_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/common/*.rc                                                  ${THEME_DIR}/gtk-2.0
  cp -r ${SRC_DIR}/gtk-2.0/assets/vimix${theme}/assets${ELSE_DARK}                      ${THEME_DIR}/gtk-2.0/assets

  if [[ ${color} == '' ]] && [[ ${theme} == '' ]]; then
    cp -r ${SRC_DIR}/gtk-2.0/assets/vimix/assets-dark-grey/pathbar_button_active.png    ${THEME_DIR}/gtk-2.0/assets
    cp -r ${SRC_DIR}/gtk-2.0/assets/vimix/assets-dark-grey/pathbar_button_prelight.png  ${THEME_DIR}/gtk-2.0/assets
  fi

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

  if [[ ${tweaks} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/gtk/3.0/gtk${color}.scss                                ${THEME_DIR}/gtk-3.0/gtk.css
    sassc $SASSC_OPT ${SRC_DIR}/gtk/3.0/gtk-dark.scss                                   ${THEME_DIR}/gtk-3.0/gtk-dark.css
  else
    cp -r ${SRC_DIR}/gtk/3.0/gtk${color}.css                                            ${THEME_DIR}/gtk-3.0/gtk.css
    cp -r ${SRC_DIR}/gtk/3.0/gtk-dark.css                                               ${THEME_DIR}/gtk-3.0/gtk-dark.css
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

  if [[ ${tweaks} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/gtk/4.0/gtk${color}.scss                                ${THEME_DIR}/gtk-4.0/gtk.css
    sassc $SASSC_OPT ${SRC_DIR}/gtk/4.0/gtk-dark.scss                                   ${THEME_DIR}/gtk-4.0/gtk-dark.css
  else
    cp -r ${SRC_DIR}/gtk/4.0/gtk${color}.css                                            ${THEME_DIR}/gtk-4.0/gtk.css
    cp -r ${SRC_DIR}/gtk/4.0/gtk-dark.css                                               ${THEME_DIR}/gtk-4.0/gtk-dark.css
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

  if [[ ${tweaks} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/gnome-shell/shell-${GS_VERSION}/gnome-shell${color}.scss ${THEME_DIR}/gnome-shell/gnome-shell.css
  else
    cp -r ${SRC_DIR}/gnome-shell/shell-${GS_VERSION}/gnome-shell${color}.css            ${THEME_DIR}/gnome-shell/gnome-shell.css
  fi

  (
  cd ${THEME_DIR}/gnome-shell
  ln -s assets/no-events.svg no-events.svg
  ln -s assets/process-working.svg process-working.svg
  ln -s assets/no-notifications.svg no-notifications.svg
  )

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

  if [[ ${tweaks} == 'true' ]]; then
    sassc $SASSC_OPT ${SRC_DIR}/cinnamon/cinnamon${color}.scss                          ${THEME_DIR}/cinnamon/cinnamon.css
  else
    cp -r ${SRC_DIR}/cinnamon/cinnamon${color}.css                                      ${THEME_DIR}/cinnamon/cinnamon.css
  fi

  cp -r ${SRC_DIR}/cinnamon/assets${theme}/common-assets                                ${THEME_DIR}/cinnamon/assets
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/checkbox/*.svg            ${THEME_DIR}/cinnamon/assets/checkbox
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/menu/*.svg                ${THEME_DIR}/cinnamon/assets/menu
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/misc/*.svg                ${THEME_DIR}/cinnamon/assets/misc
  cp -r ${SRC_DIR}/cinnamon/assets${theme}/assets${ELSE_DARK}/switch/*.svg              ${THEME_DIR}/cinnamon/assets/switch
  cp -r ${SRC_DIR}/cinnamon/thumbnail${ELSE_DARK}${theme}.png                           ${THEME_DIR}/cinnamon/thumbnail.png
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
    -r|--remove|-u|--uninstall)
      uninstall="true"
      shift
      ;;
    -l|--libadwaita)
      libadwaita="true"
      shift
      ;;
    -tweaks|--tweaks)
      shift
      for tweaks in "$@"; do
        case "$tweaks" in
          grey)
            grey="true"
            echo -e "Install grey windows button version ..."
            shift
            ;;
          flat)
            flat="true"
            echo -e "Install flat windows button version ..."
            shift
            ;;
          mix)
            mix="true"
            echo -e "Install mix dark grey version ..."
            shift
            ;;
          translucent)
            translucent="true"
            echo -e "Install translucent shell version ..."
            shift
            ;;
          -*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized tweaks variant '$1'."
            echo "Try '$0 --help' for more information."
            exit 1
            ;;
        esac
      done
      ;;
    -t|--theme)
      accent='true'
      shift
      for theme in "${@}"; do
        case "${theme}" in
          grey)
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
          jade)
            themes+=("${THEME_VARIANTS[5]}")
            shift 1
            ;;
          all)
            themes+=("${THEME_VARIANTS[@]}")
            shift 1
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized theme variant '$1'."
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
          compact)
            sizes+=("${SIZE_VARIANTS[1]}")
            compact='true'
            echo -e "Install compact version ..."
            shift 1
            ;;
          all)
            sizes+=("${SIZE_VARIANTS[@]}")
            compact='true'
            shift 1
            ;;
          -*|--*)
            break
            ;;
          *)
            echo "ERROR: Unrecognized size variant '$1'."
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

# Check command avalibility
function has_command() {
  command -v $1 > /dev/null
}

# Install needed packages
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
      sudo pacman -S --noconfirm --asdeps sassc
    fi
  fi
}

tweaks_temp() {
  cp -rf ${SRC_DIR}/_sass/_tweaks.scss ${SRC_DIR}/_sass/_tweaks-temp.scss
}

install_flat() {
  sed -i "/\$titlebutton:/s/default/flat/" ${SRC_DIR}/_sass/_tweaks-temp.scss
}

install_mix() {
  sed -i "/\$mixstate:/s/default/main/" ${SRC_DIR}/_sass/_tweaks-temp.scss
}

install_compact() {
  sed -i "/\$compact:/s/false/true/" ${SRC_DIR}/_sass/_tweaks-temp.scss
}

install_translucent() {
  sed -i "/\$translucent:/s/false/true/" ${SRC_DIR}/_sass/_tweaks-temp.scss
}

install_theme_color() {
  if [[ "$theme" != '-doder' ]]; then
    case "$theme" in
      -grey)
        theme_color='grey'
        ;;
      -beryl)
        theme_color='beryl'
        ;;
      -ruby)
        theme_color='ruby'
        ;;
      -amethyst)
        theme_color='amethyst'
        ;;
      -jade)
        theme_color='jade'
        ;;
    esac
    sed -i "/\$theme:/s/doder/${theme_color}/" ${SRC_DIR}/_sass/_tweaks-temp.scss
  fi
}

theme_tweaks() {
  if [[ "${flat}" == 'true' || "${mix}" == 'true' || "${accent}" == 'true' || "${compact}" == 'true' || "${translucent}" == 'true' ]]; then
    install_package && tweaks_temp
    tweaks='true'
  fi

  if [[ "${flat}" == 'true' ]]; then
    install_flat
  fi

  if [[ "${mix}" == 'true' ]]; then
    install_mix
  fi

  if [[ "${compact}" == 'true' && "${size}" == '-compact' ]]; then
    install_compact
  fi

  if [[ "${accent}" == 'true' ]]; then
    install_theme_color
  fi

  if [[ "${translucent}" == 'true' ]]; then
    install_translucent
  fi
}

uninstall_link() {
  rm -rf "${HOME}/.config/gtk-4.0"/{assets,gtk.css,gtk-dark.css}
}

link_libadwaita() {
  local dest="${1}"
  local name="${2}"
  local color="${3}"
  local size="${4}"
  local theme="${5}"

  local THEME_DIR="${1}/${2}${3}${4}${5}"

  echo -e "\nLink '$THEME_DIR/gtk-4.0' to '${HOME}/.config/gtk-4.0' for libadwaita..."

  mkdir -p                                                                      "${HOME}/.config/gtk-4.0"
  ln -sf "${THEME_DIR}/gtk-4.0/assets"                                          "${HOME}/.config/gtk-4.0/assets"
  ln -sf "${THEME_DIR}/gtk-4.0/gtk.css"                                         "${HOME}/.config/gtk-4.0/gtk.css"
  ln -sf "${THEME_DIR}/gtk-4.0/gtk-dark.css"                                    "${HOME}/.config/gtk-4.0/gtk-dark.css"
}

link_theme() {
  for color in "${colors[@]-${COLOR_VARIANTS[2]}}"; do
    for size in "${sizes[@]-${SIZE_VARIANTS[0]}}"; do
      for theme in "${themes[@]-${THEME_VARIANTS[1]}}"; do
        link_libadwaita "${dest:-$DEST_DIR}" "${_name:-$THEME_NAME}" "${color}" "${size}" "${theme}"
      done
    done
  done
}

uninstall() {
  local dest="${1}"
  local name="${2}"
  local color="${3}"
  local size="${4}"
  local theme="${5}"

  local THEME_DIR="${1}/${2}${3}${4}${5}"

  if [[ -d "${THEME_DIR}" ]]; then
    echo -e "Uninstall ${THEME_DIR}... "
    rm -rf "${THEME_DIR}"
  fi
}

# Uninstall theme
uninstall_theme() {
  for color in "${colors[@]-${COLOR_VARIANTS[@]}}"; do
    for size in "${sizes[@]-${SIZE_VARIANTS[@]}}"; do
      for theme in "${themes[@]-${THEME_VARIANTS[@]}}"; do
        uninstall "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}" "${theme}"
      done
    done
  done
}

# Install theme
install_theme() {
  for color in "${colors[@]-${COLOR_VARIANTS[@]}}"; do
    for size in "${sizes[@]-${SIZE_VARIANTS[0]}}"; do
      for theme in "${themes[@]-${THEME_VARIANTS[1]}}"; do
        install "${dest:-${DEST_DIR}}" "${name:-${THEME_NAME}}" "${color}" "${size}" "${theme}"
      done
    done
  done
}

if [[ "$uninstall" == 'true' ]]; then
  if [[ "$libadwaita" == 'true' ]]; then
    echo -e "\nUninstall ${HOME}/.config/gtk-4.0 links ..."
    uninstall_link
  else
    echo && uninstall_theme && uninstall_link
  fi
else
  install_theme
  if [[ "$libadwaita" == 'true' ]]; then
    uninstall_link && link_theme
  fi
fi

echo
echo Done.
