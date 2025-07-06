FROM alpine:3.20

RUN apk add snapcast-server --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
 && apk add snapweb --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/

EXPOSE 1704 1705 1780
EXPOSE 4953

# ENTRYPOINT ["snapserver", "--http.doc_root=/usr/share/snapweb"]
ENTRYPOINT ["snapserver", "--http.doc_root=/usr/share/snapweb", "--stream.source=tcp://127.0.0.1:4953?name=Mopidy&mode=server"]
#ENTRYPOINT ["snapserver", "--http.doc_root=/usr/share/snapweb", "--stream.source=file:///root/test.wav?name=File", "--stream.source=pipe:///root/snapserver/filefifo?name=filefifo"]
