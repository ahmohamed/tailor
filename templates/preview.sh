#!/bin/sh
# Render every design with the sample data -> templates/preview/NN-name.pdf (+ page-1 PNG). Usage: sh templates/preview.sh
cd "$(dirname "$0")/.." && mkdir -p templates/preview
for f in templates/designs/*.typ; do n=$(basename "$f" .typ)
  typst compile --root . "$f" "templates/preview/$n.pdf" 2>&1 | grep -v -A4 "^warning"
  pdftoppm -r 60 -png -f 1 -l 1 "templates/preview/$n.pdf" "templates/preview/$n" 2>/dev/null
  echo "$n: $(pdfinfo templates/preview/$n.pdf 2>/dev/null | awk '/Pages/{print $2}') page(s)"
done
