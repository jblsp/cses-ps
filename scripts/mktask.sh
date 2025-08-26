#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <template-file>"
  exit 1
fi

DATE=$(date +"%b %d %Y")
GPPVER=$(command -v g++ >/dev/null 2>&1 && g++ -dumpfullversion -dumpversion || echo "unknown")
read -rp "Enter task number: " TASKNUM
read -rp "Enter task name: " TASKNAME
LINK="https://cses.fi/problemset/task/$TASKNUM/"

export DATE GPPVER TASKNUM TASKNAME LINK
envsubst <"$1"

# vim: ft=bash
