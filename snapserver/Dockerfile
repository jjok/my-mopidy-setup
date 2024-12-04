FROM alpine:3.20

RUN apk add snapcast-server --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
 && apk add snapweb --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

EXPOSE 1704 1705 1780

ENTRYPOINT ["snapserver", "--http.doc_root=/usr/share/snapweb"]
