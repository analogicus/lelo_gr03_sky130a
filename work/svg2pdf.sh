#!/usr/bin/env bash
# svg2pdf.sh INPUT.svg OUTPUT.pdf
# Render SVG to vector PDF via chromium headless. rsvg-convert can't handle
# Magic's <pattern>+<filter> layer fills; chromium's full SVG engine can.
set -euo pipefail
SVG=$1
PDF=$2
W=$(grep -m1 -oE 'width="[0-9]+"' "$SVG" | grep -oE '[0-9]+')
H=$(grep -m1 -oE 'height="[0-9]+"' "$SVG" | grep -oE '[0-9]+')
TMP=$(mktemp --suffix=.html)
trap 'rm -f "$TMP"' EXIT
cat > "$TMP" <<EOF
<html><head><style>
@page { size: ${W}px ${H}px; margin: 0; }
html, body { margin: 0; padding: 0; }
img { display: block; width: ${W}px; height: ${H}px; }
</style></head>
<body><img src="file://$(realpath "$SVG")"></body></html>
EOF
chromium --headless --no-sandbox --disable-gpu --no-pdf-header-footer \
    --print-to-pdf="$PDF" "file://$TMP" 2>/dev/null
