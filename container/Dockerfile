ARG FEDORA_RELEASE=rawhide
FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_RELEASE:-rawhide} as rpmextractor

ARG ADDITIONAL_PACKAGES
ARG FEDORA_RELEASE=rawhide

ARG ENTRYPOINT_CALLS
ENV ENTRYPOINT_CALLS=${ENTRYPOINT_CALLS}

WORKDIR /workdir
COPY . .

RUN microdnf --assumeyes --no-plugins\
 --setopt install_weak_deps=false --setopt=tsflags=nocontexts --no-docs\
 --installroot=/target --use-host-config\
 $([ "${FEDORA_RELEASE}" '==' "latest" ] || echo --releasever ${FEDORA_RELEASE:-rawhide})\
 install dropbear ${ADDITIONAL_PACKAGES}

RUN rm -vrf /target/{afs,boot,dev,media,mnt,opt,proc,run,srv,sys}\
 /target/var/log/*.log\
 /target/var/cache/*\
 /target/var/tmp/*

RUN ./entrypoints-generator.sh > /target/entrypoint\
 && chmod +x /target/entrypoint

FROM scratch
COPY --from=rpmextractor /target /

EXPOSE 64022
ENTRYPOINT [ "/entrypoint" ]
