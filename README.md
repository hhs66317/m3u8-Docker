# m3u8-Docker
Download m3u8 videos with docker.

## Usage
Simpliy do the docker-compose.
The container will monitor the change of `/playlists`, which is set in compose config,  and download videos into `/recordings` with only combining ts files into a single mkv file.

## docker-compose.yml
```
version: "2.1"
services:
  transmission:
    image: hhs66317/m3u8
    container_name: m3u8
    hostname: m3u8
    volumes:
      - /share/temp/m3u8/recordings:/recordings
      - /share/temp/m3u8/playlists:/playlists
    restart: unless-stopped
```

## Tips
If there are changes in `/playlists`, the container will download every m3u8 files whose corresponding mkv file does not exist in `/recordings`.
Thus, when moving mkv files, please remember to delete or move the corresponding m3u8 file too. Otherwise, the mkv file will be downloaded on next `/playlists` change, which is duplicated and might not be the result you are expecting.
