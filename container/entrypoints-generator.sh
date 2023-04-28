#!/bin/sh -ex

# This file is not the entrypoint itself
# Running this file you can generate the entrypoint you need

# The main scenario for the entrypoint is:
#  1 (optional): configure and fork additional processes (Example: Vipnet Client)
#                based on ENTRYPOINT_CALLS build-arg values
#  2 (must run): configure and exec dropbear-sshd daemon

echo -e '#!/bin/sh -e\n'

echo "trap 'exec /usr/sbin/dropbear -RFEgsa -p \${SSHD_PORT:-64022}' EXIT"

for c in ${ENTRYPOINT_CALLS}
do
 cat << ENTRYPOINT_CALL

echo "ENTRYPOINT: starting ${c}"
$(cat ${c}*.entrypoint)
echo "ENTRYPOINT: ${c} started"

ENTRYPOINT_CALL
done

cat << 'AUTHORIZED_KEYS'
if ! [ -z "${AUTHORIZED_KEYS}" ]
then
 echo -e '\nENTRYPOINT: preparing authorized_keys'
 mkdir -vp "${HOME}/.ssh"
 echo "${AUTHORIZED_KEYS}" > "${HOME}/.ssh/authorized_keys"
 chmod -v go-w "${HOME}" "${HOME}/.ssh" "${HOME}/.ssh/authorized_keys"
 unset AUTHORIZED_KEYS # no trust
fi

echo -e '\nENTRYPOINT: End'
AUTHORIZED_KEYS
