
ARG FEDORA_RELEASE=rawhide
FROM fedora:${FEDORA_RELEASE:-rawhide} as rpmextractor

# Place RPM's to the current dir, if needed
COPY *.rpm /tmp

# Or select ADDITIONAL_PACKAGES from repos
ARG ADDITIONAL_PACKAGES
arg FEDORA_RELEASE=rawhide

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
