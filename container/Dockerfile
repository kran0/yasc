FROM docker.io/library/alpine:edge AS prepare

ARG ENTRYPOINT_CALLS
WORKDIR /tmp/prepare
COPY . /tmp/prepare

# Copy dropbear to the /target
COPY --from=docker.io/kran0/tiny:dropbear / /target

# TODO: It must be buggy. Better use tar.gz static versions
# Try to unpack strange rpm's (like vipnetclient) to the /target
RUN apk add --update --virtual .temp rpm2cpio\
 && for rpm in *.rpm; do rpm2cpio ${rpm} | (cd /target && cpio -idmv); done\
 && rm -rvf /target/usr/share/man\
 && apk del .temp

RUN mkdir -vp /target/etc/dropbear\
 && ./entrypoints-generator.sh ${ENTRYPOINT_CALLS} > /target/entrypoint\
 && chmod +x /target/entrypoint\
 && echo 'root:x:0:0:root:/root:/bin/sh' > /target/etc/passwd

FROM scratch
COPY --from=prepare /target /

EXPOSE 64022
ENTRYPOINT [ "/entrypoint" ]
