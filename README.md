YASC: Yet another SSHd container

# Important note!

This container is based on the [https://github.com/kran0/tinyimages](tinyimages) dropbear 
and adds some buggy instructions for make Vipnet-Clinet running with dropbear.

Your vipnet-client installation may need iptables for run or may not run.

__Better not use this container__

# Run service with podman-compose

- Simple Start/stop service:

```bash
  podman-compose up -d
  podman-compose down
```

- Start/stop service with ssh authorized_keys set up

```bash
  edit ./docker-compose.yaml (or add docker-compose.override.yml) and set AUTHORIZED_KEYS varialbe
  podman-compose up -d
  podman-compose down
```

- Start/stop service script example

```bash
#!/bin/sh -ex

: Start
alias compose='cd "${HOME}/Documents/vipnet-container/"; podman-compose'

: Trap stop vipnet-container
#trap ': Trap exit; compose down' EXIT

: Strat vipnet-container
compose up --detach --force-recreate --build

: Check vipnet-container
until podman healthcheck run vipnet-container_sshd_1
do
 sleep 0.2s
done
 
: Strat ssh-proxy untill run duration ends
DURATION=$(($(date --date '18:20:00' +%s)-$(date +%s))) # sleep until 18:20
[ "${DURATION}" -lt 3600 ] && DURATION=$((2*60*60))     # if it is evening now

timeout --foreground --verbose ${DURATION} ssh -ND 1080 polygon.proxyjump

: Finish
```
