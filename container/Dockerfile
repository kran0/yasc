FROM fedora:rawhide as rpmextractor

# Place RPM's to the current dir, if needed
COPY . .

ARG ADDITIONAL_PACKAGES

RUN dnf --verbose --assumeyes install\
 --installroot /target --releasever rawhide\
 --setopt install_weak_deps=false\
 dropbear ${ADDITIONAL_PACKAGES}

# remove unused depencies
RUN rm -rvf\
 /target/{afs,boot,dev,home,lib,sbin,media,mnt,opt,proc,run,srv,sys,tmp}\
 /target/usr/{games,libexec,local,share,src,tmp}\
 /target/usr/lib64/{X11,audit,bpf,games,gconv,pm-utils}

FROM scratch

COPY --from=rpmextractor /target /

EXPOSE 64022
ENTRYPOINT [ "/usr/sbin/dropbear" ]
CMD [ "-RFEgsa", "-p", "64022" ]
