#! /bin/bash

SRC="$1"
DST="$2"

if [ -f "${SRC}.rsync-excludes" ]; then
  EXCLUDES="${SRC}.rsync-excludes"
elif [ -f "~/.rsync-excludes" ]; then
  EXCLUDES="~/.rsync-excludes"
fi

rsync -av --delete --delete-excluded --exclude-from="$EXCLUDES" "$SRC" "$DST"

