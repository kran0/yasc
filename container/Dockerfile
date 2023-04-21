ARG FEDORA_RELEASE=rawhide
FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_RELEASE:-rawhide} as rpmextractor

ARG ADDITIONAL_PACKAGES
ARG FEDORA_RELEASE=rawhide

WORKDIR /workdir
COPY *.rpm .

RUN microdnf --assumeyes --no-plugins\
 --setopt install_weak_deps=false --setopt=tsflags=nocontexts --no-docs\
 --installroot=/target --use-host-config\
 $([ "${FEDORA_RELEASE}" '==' "latest" ] || echo --releasever ${FEDORA_RELEASE:-rawhide})\
 install dropbear ${ADDITIONAL_PACKAGES}

FROM scratch
COPY --from=rpmextractor /target /

EXPOSE 64022
ENTRYPOINT [ "/usr/sbin/dropbear" ]
CMD [ "-RFEgsa", "-p", "64022" ]
