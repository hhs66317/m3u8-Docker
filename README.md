# m3u8-Docker
Download m3u8 videos with docker.

# use
修改文件 `/playlists/list.txt`
```
xxx.mp4|http://xxxxx.m3u8
yyy.mp4|http://yyyyy.m3u8
```

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
