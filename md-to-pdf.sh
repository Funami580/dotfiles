#!/bin/bash
name=$(rev <<< "$1" | cut -d'.' -f2- | rev)
out="${name}.pdf"
entr -r pandoc -f markdown+hard_line_breaks "$1" -o "$out" <<< "$1"
