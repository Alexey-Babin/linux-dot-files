#!/bin/sh
case "$1" in
  *.tar*) tar tf "$1";;
  *.zip) unzip -l "$1";;
  *.pdf) pdftotext "$1";;
  *.png|*.jpg|*.gif|*.bmp) chafa -c 256 "$1";;
  *) if [ "$(file --mime "$1" | grep -ic binary$)" -ge 1 ]; then 
    file "$1"
  else 
    batcat --color=always --plain "$1" || cat {}
  fi
esac
