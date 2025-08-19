#!/usr/bin/env bash
set -euo pipefail

FILE="public/index.html"
if [[ ! -f "$FILE" ]]; then
  echo "ERROR: $FILE not found"
  exit 1
fi

LENGTH=$(wc -c < "$FILE" | tr -d ' ')
if (( LENGTH < 100 )); then
  echo "ERROR: $FILE seems too short ($LENGTH bytes). Expect >=100 bytes"
  exit 2
fi

# optional check: file contains <html> tag
if ! grep -iq "<html" "$FILE"; then
  echo "ERROR: $FILE does not appear to contain <html> tag"
  exit 3
fi

echo "OK: $FILE exists, size=${LENGTH} bytes, basic checks passed"