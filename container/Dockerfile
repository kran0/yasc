FROM docker.io/library/alpine:edge as prepare

ARG ADDITIONAL_PACKAGES
ARG ENTRYPOINT_CALLS

WORKDIR /tmp/prepare
COPY . .
ADD https://raw.githubusercontent.com/kran0/tinyimages/master/apkextractor.sh .

# Copy dropbear and additional packages tree to the /target
RUN /bin/sh ./apkextractor.sh dropbear ${ADDITIONAL_PACKAGES}\
 && mkdir -vp /target/etc/dropbear

# TODO: It must be buggy. Better use tar.gz static versions
# Try to unpack strange rpm's (like vipnetclient) to the /target
RUN apk add --update rpm2cpio\
 && for rpm in *.rpm; do rpm2cpio ${rpm} | (cd /target && cpio -idmv); done

# Create /target/entrypoint
RUN ./entrypoints-generator.sh ${ENTRYPOINT_CALLS} > /target/entrypoint\
 && chmod +x /target/entrypoint

FROM docker.io/library/busybox:musl
COPY --from=prepare /target /

EXPOSE 64022
ENTRYPOINT [ "/entrypoint" ]
