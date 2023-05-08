#!/bin/bash
name=$(rev <<< "$1" | cut -d'.' -f2- | rev)
out="${name}.pdf"
d=$(dirname "$0")
header="$d/header.tex"
entr -r pandoc -H "$header" -f markdown+hard_line_breaks+superscript+subscript+raw_html+raw_tex-markdown_in_html_blocks "$1" -s -o "$out" <<< "$1"$'\n'"$header"
