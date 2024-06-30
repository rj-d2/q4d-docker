# Q4D-docker

**Unofficial Docker Image**

This repository provides an unofficial Docker image for the client side of [Queue4Download](https://github.com/weaselBuddha/Queue4Download). Please refrain from contacting the original developers for support related to this Docker image.

## Prerequisites

1. **Mosquitto Service**: Ensure that the Mosquitto service is already running on your seedbox.
2. **Configuration Files**: Download and copy the configuration files and scripts from the `config_files` folder into your desired AppData location (e.g., `/mnt/user/appdata/Q4D`).

## Configuration

1. **Edit Configuration Files**: Edit the following files to match your environment:
    - `Q4Ddefines.sh`
    - `Q4Dconfig.sh`
    - `Q4Dclient.sh`

## Starting the Docker Container

### Using Docker Compose

1. **Create a `docker-compose.yml` file** with the following content:

    ```yaml
    version: '3'
    services:
      Q4D:
        image: ghcr.io/rj-d2/q4d-docker:latest
        container_name: q4d
        volumes:
          - /path/to/appdata:/root/.Q4D  # Persistent storage for Q4D config
          - /path/to/appdata/.ssh:/root/.ssh  # SSH configuration
          - /path/to/download_dir:/data  # Data storage
        ports:
          - "1883:1883"  # MQTT (Mosquitto) port mapping
          - "6546:22"    # SSH port mapping
        restart: unless-stopped
    ```

    Replace `/path/to/appdata`, `/path/to/appdata/.ssh`, and `/path/to/download_dir` with your actual paths.

2. **Run Docker Compose**:

    ```sh
    docker-compose up -d
    ```

### Using Docker Run Command

If you prefer to run the container directly, use the following command:

```sh
docker run -d \
  --name q4d \
  -v /path/to/appdata:/root/.Q4D \
  -v /path/to/appdata/.ssh:/root/.ssh \
  -v /path/to/download_dir:/data \
  -p 1883:1883 \
  -p 6546:22 \
  --restart unless-stopped \
  ghcr.io/rj-d2/q4d-docker:latest
```

Replace `/path/to/appdata`, `/path/to/appdata/.ssh`, and `/path/to/download_dir` with your actual paths.

## Accessing the Docker Container

To access the shell of the running Docker container, use:

```sh
docker exec -it q4d /bin/bash
```

### Generating SSH Keys

Inside the Docker container shell, generate SSH keys:

```sh
ssh-keygen
```

Simply press `Enter` to accept the default options and generate the keys.

### Copying SSH Key to Seedbox

Copy the generated SSH key to your seedbox:

```sh
ssh-copy-id USERNAME@SEEDBOX_IP
```

Replace `USERNAME` with your actual username and `SEEDBOX_IP` with the IP address of your seedbox. Enter the seedbox password when prompted.

### Verifying SSH Access

Now, you should be able to access the seedbox using:

```sh
ssh USERNAME@SEEDBOX_IP
```

This setup allows `lftp` to use the SSH key for accessing the seedbox, enabling secure and automated downloads.

