#!/bin/sh -e

/usr/bin/vipnetclient info

[ -z "${VIPNET_KEY_CONTAINER_FILE}" ] || (
 /usr/bin/vipnetclient --no-start --psw ${VIPNET_KEY_CONTAINER_PASSWORD} installkeys ${VIPNET_KEY_CONTAINER_FILE}
)
unset VIPNET_KEY_CONTAINER_PASSWORD\
      VIPNET_KEY_CONTAINER_FILE

/usr/bin/vipnetclient start

[ -z "${AUTHORIZED_KEYS}" ] || (
 mkdir -vp "${HOME}/.ssh"
 echo "${AUTHORIZED_KEYS}" > "${HOME}/.ssh/authorized_keys"
 chmod -v go-w "${HOME}" "${HOME}/.ssh" "${HOME}/.ssh/authorized_keys"
)
unset AUTHORIZED_KEYS

exec /usr/sbin/dropbear -RFEgsa -p ${SSHD_PORT:-64022}
