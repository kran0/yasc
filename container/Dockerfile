ARG FEDORA_RELEASE=rawhide
FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_RELEASE:-rawhide} as rpmextractor

WORKDIR /tmp

# Place RPM's to /tmp
COPY *.rpm .

# Select ADDITIONAL_PACKAGES
ARG ADDITIONAL_PACKAGES

ARG FEDORA_RELEASE=rawhide

RUN microdnf --assumeyes --noplugins\
  --config=/etc/dnf/dnf.conf --setopt=reposdir=/etc/yum.repos.d\
  --installroot=/target  $([ "${FEDORA_RELEASE}" '==' "latest" ] || echo --releasever ${FEDORA_RELEASE:-rawhide})\
  --setopt install_weak_deps=false\
  --setopt=tsflags=nocontexts\
  install\
 dropbear ${ADDITIONAL_PACKAGES}\
 && microdnf clean all && rm -vrf /var/cache/yum

FROM scratch
COPY --from=rpmextractor /target /

EXPOSE 64022
ENTRYPOINT [ "/usr/sbin/dropbear" ]
CMD [ "-RFEgsa", "-p", "64022" ]
