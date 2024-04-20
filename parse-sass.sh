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

cp -rf src/_sass/_tweaks.scss src/_sass/_tweaks-temp.scss

for color in "${_COLOR_VARIANTS[@]}"; do
  sassc $SASSC_OPT src/gtk/3.0/gtk${color}.{scss,css}
  echo "==> Generating the 3.0 gtk${color}.css..."
  sassc $SASSC_OPT src/gtk/4.0/gtk${color}.{scss,css}
  echo "==> Generating the 4.0 gtk${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/shell-3-28/gnome-shell${color}.{scss,css}
  echo "==> Generating the 3.28 gnome-shell${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/shell-40-0/gnome-shell${color}.{scss,css}
  echo "==> Generating the 40.0 gnome-shell${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/shell-42-0/gnome-shell${color}.{scss,css}
  echo "==> Generating the 42.0 gnome-shell${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/shell-44-0/gnome-shell${color}.{scss,css}
  echo "==> Generating the 44.0 gnome-shell${color}.css..."
  sassc $SASSC_OPT src/gnome-shell/shell-46-0/gnome-shell${color}.{scss,css}
  echo "==> Generating the 46.0 gnome-shell${color}.css..."
  sassc $SASSC_OPT src/cinnamon/cinnamon${color}.{scss,css}
  echo "==> Generating the cinnamon${color}.css..."
done
