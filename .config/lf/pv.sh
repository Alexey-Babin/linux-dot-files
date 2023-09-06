#!/bin/sh
case "$1" in
  *.tar*) tar tf "$1";;
  *.zip) unzip -l "$1";;
  *.pdf) pdftotext "$1";;
  *.png|*.jpg|*.gif|*.bmp) chafa -c 256 "$1";;
  *) batcat --color=always --plain "$1"
esac
