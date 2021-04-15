#!/bin/bash

PLAYLISTS_DIR=/playlists
RECORDINGS_DIR=/recordings

function record {
  local -r IN=$1
  local -r OUT=$2
  echo "ffmpeg -protocol_whitelist \"file,http,https,tcp,tls\" -i \"${IN}\" -vcodec copy -acodec copy -copyts -y \"${OUT}\""
  ffmpeg -protocol_whitelist "file,http,https,tcp,tls" -i "${IN}" -vcodec copy -acodec copy -copyts -y "${OUT}"
  # ffmpeg -i "${IN}" "${OUT}"
}

function block_for_change {
  inotifywait \
    --event modify,move,create,delete \
    $PLAYLISTS_DIR
}

function build {

  for line in `cat ${PLAYLISTS_DIR}/list.txt`
  do
    readarray -d '|' -t item_arr <<<"$line"

    # m3u8_path="${item_arr[1]}"
    m3u8_path=`echo ${item_arr[1]} | tr -d "\n"`
    mp4_path="${RECORDINGS_DIR}/${item_arr[0]}"

    echo "mp4_path: ${mp4_path}"
    echo "m3u8_path: ${m3u8_path}"

    if [ -f ${mp4_path} ]; then
      echo "Skipping ${item_arr[0]}, already recorded!"
    else
      echo "${m3u8_path} > ${mp4_path}"
      record "${m3u8_path}" "${mp4_path}"
    fi

    echo "Everything is done!"
  done
}

build

while block_for_change; do
  build
done
