YASC: Yet another SSHd container

# Run service with podman-compose

- Simple Start/stop service:

```bash
  podman-compose -f ./compose.yaml up -d
  podman-compose -f ./compose.yaml down
```

- Start/stop service with ssh authorized_keys set up

```bash
  edit ./compose-env.yaml
  podman-compose -f ./compose.yaml -f ./compose-env.yaml up -d
  podman-compose -f ./compose.yaml -f ./compose-env.yaml down
```

- Start/stop service using bash script

```bash
  chmod +x ./compose.yaml
  ./compose.yaml up -d
  ./compose.yaml down
```

# Docker tags

[![Automated][badge_docker_automated]][link_docker_tags]
[![Build][badge_docker_build]][link_docker_builds]

| Repository:Tag | Description |
|:--|---|
| kran0/sshd:latest     | latest sshd + alpine |
| kran0/sshd:{sourceref}-alpine      | tagged sshd + alpine |
| kran0/sshd:{sourceref}-fedora      | tagged sshd + fedora |

---
[badge_docker_automated]:https://img.shields.io/docker/cloud/automated/kran0/sshd?style=for-the-badge&cacheSeconds=3600
[badge_docker_build]:https://img.shields.io/docker/cloud/build/kran0/sshd?style=for-the-badge&cacheSeconds=3600
[link_docker_tags]:https://hub.docker.com/r/kran0/sshd/tags?page=1&ordering=last_updated
[link_docker_builds]:https://hub.docker.com/r/kran0/sshd/builds
