FROM docker.io/kran0/tiny:dropbear-pure AS dropbear
FROM docker.io/library/alpine:edge AS prepare

ARG ENTRYPOINT_CALLS
WORKDIR /tmp/prepare
COPY . /tmp/prepare

# Copy dropbear and additional packages tree to the /target
COPY --from=dropbear / /target
RUN mkdir -vp /target/etc/dropbear

# TODO: It must be buggy. Better use tar.gz static versions
# Try to unpack strange rpm's (like vipnetclient) to the /target
RUN apk add --update rpm2cpio\
 && for rpm in *.rpm; do rpm2cpio ${rpm} | (cd /target && cpio -idmv); done\
 && rm -rvf /target/usr/share/man

# Create /target/entrypoint
RUN ./entrypoints-generator.sh ${ENTRYPOINT_CALLS} > /target/entrypoint\
 && chmod +x /target/entrypoint

FROM docker.io/library/busybox:latest
COPY --from=prepare /target /

EXPOSE 64022
ENTRYPOINT [ "/entrypoint" ]
