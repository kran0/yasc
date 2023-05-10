#!/bin/sh -ex

# This file is not the entrypoint itself
# Running this file you can generate the entrypoint you need

# The main scenario for the entrypoint is:
#  1 (optional): configure and fork additional processes (Example: Vipnet Client)
#                based on ENTRYPOINT_CALLS build-arg values
#  2 (must run): configure and exec dropbear-sshd daemon

BASEDIR=$(dirname ${0})

echo -e '#!/bin/ash -e\n'

echo "trap 'exec /usr/sbin/dropbear -RFEgsa -p \${SSHD_PORT:-64022}' EXIT"

for c in ${ENTRYPOINT_CALLS:-${@}}
do
 cat ${BASEDIR}/${c}*.entrypoint
done

cat << 'AUTHORIZED_KEYS'
if ! [ -z "${AUTHORIZED_KEYS}" ]
then
 echo -e '\nENTRYPOINT: prepare authorized_keys'
 mkdir -vp "${HOME}/.ssh"
 echo "${AUTHORIZED_KEYS}" > "${HOME}/.ssh/authorized_keys"
 chmod -v go-w "${HOME}" "${HOME}/.ssh" "${HOME}/.ssh/authorized_keys"
 unset AUTHORIZED_KEYS # no trust
fi

echo -e '\nENTRYPOINT: End'
AUTHORIZED_KEYS
