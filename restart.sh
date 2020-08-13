#!/bin/sh

pushd $(dirname $0)
trap 'popd' EXIT

source ./.env
COMPOSE="./compose.yaml"

function question {
 read -r -p "${q:-1}: [y/N] "
 [[ "${REPLY}" =~ ^([yY][eE][sS]|[yY])$ ]] && ${@}
}

#q="Fix ${PWD} file permissions?"  question chcon -vRt svirt_sandbox_file_t . && chmod -vR o+rw .
q='Stop sshd-container?'          question "${COMPOSE}" down  && sleep 8s
q='Build sshd-container?'         question "${COMPOSE}" build || exit 1
q='Start sshd-container?'         question "${COMPOSE}" up -d && sleep 8s

q="Test sshd?"  question ssh root@localhost -p ${SSHD_EXTERNAL_PORT:-${SSHD_PORT}} -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no true && echo 'Test Passed.'
