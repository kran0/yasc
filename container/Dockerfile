ARG FEDORA_RELEASE=rawhide
FROM registry.fedoraproject.org/fedora-minimal:${FEDORA_RELEASE:-rawhide}

# Place RPM's to /tmp
COPY *.rpm /tmp

# Select ADDITIONAL_PACKAGES
ARG ADDITIONAL_PACKAGES

ARG FEDORA_RELEASE=rawhide

RUN cd /tmp\
 && microdnf --assumeyes install\
 $([ "${FEDORA_RELEASE}" '==' "latest" ] || echo --releasever ${FEDORA_RELEASE:-rawhide})\
 --setopt install_weak_deps=false\
 --setopt=tsflags=nocontexts\
 dropbear ${ADDITIONAL_PACKAGES}\
 && microdnf clean all && rm -vrf /var/cache/yum

EXPOSE 64022
ENTRYPOINT [ "/usr/sbin/dropbear" ]
CMD [ "-RFEgsa", "-p", "64022" ]
