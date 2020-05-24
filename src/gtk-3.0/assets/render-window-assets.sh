#! /bin/bash

INKSCAPE="/usr/bin/inkscape"
OPTIPNG="/usr/bin/optipng"

SRC_FILE="window-assets.svg"
ASSETS_DIR="window-assets"
CON_SRC_FILE="window-assets-contrast.svg"
CON_ASSETS_DIR="window-assets-contrast"
INDEX="window-assets.txt"

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

if [ -f $CON_ASSETS_DIR/$i.png ]; then
    echo $CON_ASSETS_DIR/$i.png exists.
else
    echo
    echo Rendering $CON_ASSETS_DIR/$i.png
    $INKSCAPE --export-id=$i \
              --export-id-only \
              --export-filename=$CON_ASSETS_DIR/$i.png $CON_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $CON_ASSETS_DIR/$i.png
fi
if [ -f $CON_ASSETS_DIR/$i@2.png ]; then
    echo $CON_ASSETS_DIR/$i@2.png exists.
else
    echo
    echo Rendering $CON_ASSETS_DIR/$i@2.png
    $INKSCAPE --export-id=$i \
              --export-dpi=180 \
              --export-id-only \
              --export-filename=$CON_ASSETS_DIR/$i@2.png $CON_SRC_FILE >/dev/null \
    && $OPTIPNG -o7 --quiet $CON_ASSETS_DIR/$i@2.png
fi

done
exit 0
