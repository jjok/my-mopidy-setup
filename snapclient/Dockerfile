FROM alpine:3.20

RUN apk add snapcast-client --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/

#RUN apk add openrc avahi
#RUN rc-update add avahi-daemon

#RUN rc-service avahi-daemon start

ENTRYPOINT ["snapclient"]
