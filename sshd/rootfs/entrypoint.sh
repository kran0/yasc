#!/bin/sh

# place ~/.ssh/authorized_keys
[ -z "${AUTHORIZED_KEYS}" ] || (
 mkdir -vp "${HOME}/.ssh"
 echo "${AUTHORIZED_KEYS}" > "${HOME}/.ssh/authorized_keys"
 chmod -v go-w "${HOME}" "${HOME}/.ssh" "${HOME}/.ssh/authorized_keys"
)

# generate host keys if not present
ssh-keygen -A

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
