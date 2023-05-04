YASC: Yet another SSHd container

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
