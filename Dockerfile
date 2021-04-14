FROM alpine

COPY entrypoint.sh /

RUN apk update \
    && apk add --no-cache ca-certificates ffmpeg libva-intel-driver inotify-tools bash \
    && chmod +x /entrypoint.sh \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

CMD /entrypoint.sh
