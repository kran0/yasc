ARG FEDORA_RELEASE=rawhide
FROM fedora:${FEDORA_RELEASE:-rawhide} as rpmextractor

# Place RPM's to /tmp
COPY *.rpm /tmp

# Select ADDITIONAL_PACKAGES
ARG ADDITIONAL_PACKAGES

ARG FEDORA_RELEASE=rawhide

RUN cd /tmp\
 && dnf --verbose --assumeyes install\
 $([ "${FEDORA_RELEASE}" '==' "latest" ] || echo --releasever ${FEDORA_RELEASE:-rawhide})\
 --setopt install_weak_deps=false\
 --setopt=tsflags=nocontexts\
 dropbear ${ADDITIONAL_PACKAGES}\
 && dnf --verbose clean all && rm -vrf /var/cache/yum

EXPOSE 64022
ENTRYPOINT [ "/usr/sbin/dropbear" ]
CMD [ "-RFEgsa", "-p", "64022" ]
