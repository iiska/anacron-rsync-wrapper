#! /bin/bash

SRC="$1"
DST="$2"

if [ -f "${SRC}.rsync-excludes" ]; then
  EXCLUDES="--exclude-from=${SRC}.rsync-excludes"
elif [ -f "~/.rsync-excludes" ]; then
  EXCLUDES="--exclude-from=~/.rsync-excludes"
else
  EXCLUDES=""
fi

rsync -av --delete --delete-excluded "$EXCLUDES" "$SRC" "$DST"

