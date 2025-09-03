#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <run-cmd> <tests-dir>"
  exit 1
fi

shopt -s nullglob

RUNCMD=$1
DIR=$2

SEPARATOR="-----------------------------------"

if [ ! -d "$DIR" ]; then
  echo "Error: $DIR is not a directory."
  exit 1
fi

if [ ! -x "$RUNCMD" ]; then
  echo "Error: $RUNCMD is not executable."
  exit 1
fi

TESTS=0
PASSES=0

echo $SEPARATOR
INFILES=$(find "$DIR" -maxdepth 1 -name '*.in' | sort -V)
for infile in $INFILES; do
  ((TESTS++))
  outfile="${infile%.*}.out"
  printf "%s: " "$(basename "${infile%.*}")"

  output=$("$RUNCMD" <"$infile")
  if [ ! -f "$outfile" ]; then
    echo "[FAIL?]"
    echo "Could not find outfile named $(basename "$outfile") in dir $(dirname "$outfile")"
    echo "Got:"
    echo "$output"
  elif diff -q <(echo "$output") "$outfile" >/dev/null; then
    ((PASSES++))
    echo "[PASS]"
  else
    echo "[FAIL]"
    echo "Expected:"
    cat "$outfile"
    echo "Got:"
    echo "$output"
  fi
  echo $SEPARATOR
done

echo
echo "Results: Passed $PASSES/$TESTS test(s)."
echo

# vim: ft=bash
