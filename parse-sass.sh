#! /usr/bin/env bash

if [ ! "$(which sassc 2> /dev/null)" ]; then
   echo sassc needs to be installed to generate the css.
   exit 1
fi

SASSC_OPT="-M -t expanded"

_COLOR_VARIANTS=('' '-light' '-dark')
if [ ! -z "${COLOR_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _COLOR_VARIANTS <<< "${COLOR_VARIANTS:-}"
fi

_SIZE_VARIANTS=('' '-laptop')
if [ ! -z "${SIZE_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _SIZE_VARIANTS <<< "${SIZE_VARIANTS:-}"
fi

_THEME_VARIANTS=('' '-ruby' '-doder' '-beryl' '-amethyst')
if [ ! -z "${THEME_VARIANTS:-}" ]; then
  IFS=', ' read -r -a _THEME_VARIANTS <<< "${THEME_VARIANTS:-}"
fi

for color in "${_COLOR_VARIANTS[@]}"; do
  for size in "${_SIZE_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[@]}"; do
    sassc $SASSC_OPT src/gtk-3.0/gtk${color}${size}${theme}.{scss,css}
    echo "==> Generating the gtk${color}${size}${theme}.css..."
    done
  done
done

for color in "${_COLOR_VARIANTS[@]}"; do
  for size in "${_SIZE_VARIANTS[@]}"; do
    for theme in "${_THEME_VARIANTS[@]}"; do
    sassc $SASSC_OPT src/gnome-shell/gnome-shell${color}${size}${theme}.{scss,css}
    echo "==> Generating the gnome-shell${color}${size}${theme}.css..."
    done
  done
done

for theme in "${_THEME_VARIANTS[@]}"; do
  sassc $SASSC_OPT src/cinnamon/cinnamon${theme}.{scss,css}
  echo "==> Generating the cinnamon${theme}.css..."
  sassc $SASSC_OPT src/cinnamon/cinnamon-dark${theme}.{scss,css}
  echo "==> Generating the cinnamon-dark${theme}.css..."
done
