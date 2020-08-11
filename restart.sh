#!/bin/sh

pushd $(dirname $0)
trap 'popd' EXIT

source ./.env
COMPOSE="./compose.yaml"

function question {
 read -r -p "${q:-1}: [y/N] "
 [[ "${REPLY}" =~ ^([yY][eE][sS]|[yY])$ ]] && ${@}
}

q="Fix ${PWD} file permissions?"  question chcon -vRt svirt_sandbox_file_t . && chmod -vR o+rw .
q='Stop sshd-container?'          question "${COMPOSE}" down && sleep 8s
q='Build sshd-container?'         question "${COMPOSE}" build
q='Start sshd-container?'         question "${COMPOSE}" up -d
