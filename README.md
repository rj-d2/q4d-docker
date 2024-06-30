# Q4D-docker

**Unofficial Docker Image**

This repository provides an unofficial Docker image for Q4D and is not affiliated in any way with Q4D.
Please refrain from contacting the original developers for support related to this Docker image.

## Using docker-compose

1. Create a `docker-compose.yml` file with the following content:

    ```yaml
    version: '3'
    services:
      Q4D:
        image: ghcr.io/rj-d2/Q4D-docker:latest
        container_name: Q4D
        volumes:
          - /path/to/appdata:/root/.Q4D
        restart: unless-stopped
    ```
