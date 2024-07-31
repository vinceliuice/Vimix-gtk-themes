#! /bin/bash

THEME_DIR=$(cd $(dirname $0) && pwd)

THEME_NAME=Vimix

_COLOR_VARIANTS=('' '-light' '-dark')
_SIZE_VARIANTS=('' '-compact')
_THEME_VARIANTS=('-grey' '-doder' '-beryl' '-ruby' '-jade' '-amethyst')

if [ ! -z "${SIZE_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _SIZE_VARIANTS <<< "${SIZE_VARIANTS:-}"
fi

if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

if [ ! -z "${THEME_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"
fi

Tar_themes() {
  for theme in "${_THEME_VARIANTS[@]}"; do
    rm -rf "${THEME_NAME}${theme}".tar
    rm -rf "${THEME_NAME}${theme}".tar.xz
  done

  for theme in "${_THEME_VARIANTS[@]}"; do
    tar -Jcvf "${THEME_NAME}${theme}".tar.xz "${THEME_NAME}"{'','-light','-dark'}{'','-compact'}"${theme}"
  done
}

Clear_theme() {
  for color in "${_COLOR_VARIANTS[@]}"; do
    for size in "${_SIZE_VARIANTS[@]}"; do
      for theme in "${_THEME_VARIANTS[@]}"; do
        rm -rf "${THEME_NAME}${color}${size}${theme}"{'','-hdpi','-xhdpi'}
      done
    done
  done
}

cd .. && ./install.sh -d "$THEME_DIR" -s all -t all
cd "$THEME_DIR" && Tar_themes && Clear_theme

