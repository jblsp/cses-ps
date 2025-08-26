#!/bin/bash

if [ $# -ne 2 ]; then
  echo "Usage: $0 <binary> <tests-dir>"
  exit 1
fi

shopt -s nullglob

BINARY=$1
DIR=$2

if [ ! -d "$DIR" ]; then
  echo "Error: $DIR is not a directory."
  exit 1
fi

if [ ! -x "$BINARY" ]; then
  echo "Error: $BINARY is not executable."
  exit 1
fi

TESTS=0
PASSES=0

mapfile -t TEST_FILES < <(find "$DIR" -maxdepth 1 -name '*.in' | sort -V)
for infile in "${TEST_FILES[@]}"; do
  ((TESTS++))
  CASENAME=$(basename "${infile%.*}")
  outfile="${infile%.*}.out"
  printf "%s: " "$CASENAME"

  output=$("$BINARY" <"$infile")
  if [ ! -f "$outfile" ]; then
    echo "[FAIL?]"
    echo "No output file found."
    echo "Got:"
    echo "$output"
    echo "-----------------------------------"
  elif diff -q <(echo "$output") "$outfile" >/dev/null; then
    ((PASSES++))
    echo "[PASS]"
  else
    echo "[FAIL]"
    echo "Expected:"
    cat "$outfile"
    echo "Got:"
    echo "$output"
    echo "-----------------------------------"
  fi
done

echo
echo "Results: Passed $PASSES/$TESTS test(s)."

# vim: ft=bash
