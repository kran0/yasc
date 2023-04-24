#!/bin/sh -e

[ -z "${AUTHORIZED_KEYS}" ] || (
 mkdir -vp "${HOME}/.ssh"
 echo "${AUTHORIZED_KEYS}" > "${HOME}/.ssh/authorized_keys"
 chmod -v go-w "${HOME}" "${HOME}/.ssh" "${HOME}/.ssh/authorized_keys"
)
unset AUTHORIZED_KEYS

exec /usr/sbin/dropbear -RFEgsa -p ${SSHD_PORT:-64022}
