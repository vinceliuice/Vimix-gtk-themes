#! /usr/bin/env bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

INDEX="assets.txt"

for color in '' '-ruby' '-doder' '-beryl' '-amethyst'; do

ASSETS_DIR="assets${color}"
SRC_FILE="assets${color}.svg"

for i in `cat $INDEX`
do 
if [ -f $ASSETS_DIR/$i.png ]; then
    echo $ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i.png
fi
if [ -f $ASSETS_DIR/$i@2.png ]; then
    echo $ASSETS_DIR/$i@2.png exists.
else
    echo
    echo Rendering $ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              --export-filename=$ASSETS_DIR/$i@2.png $SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $ASSETS_DIR/$i@2.png
fi
done
done
exit 0
