# Q4D-Docker

**Unofficial Docker Image**

This repository provides an unofficial Docker image for the client side of [Queue4Download](https://github.com/weaselBuddha/Queue4Download). Please refrain from contacting the original developers for support related to this Docker image.

## Prerequisites

1. **Mosquitto Service**: Ensure that the Mosquitto service is already running on your seedbox.
2. **Configuration Files**: Download and copy the configuration files and scripts from the `config_files` folder into your desired AppData location (e.g., `/mnt/user/appdata/Q4D`).

## Configuration

1. **Edit Configuration Files**: Edit the following files to match your environment:
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

## Verifying Mosquitto Connection

To verify that the Docker Mosquitto is working and connected to the seedbox, you can check the Docker container logs. The log should show connection messages if Mosquitto is functioning correctly.

1. **Show Docker Logs**: Use the following command to display the Docker logs:

    ```sh
    docker logs q4d
    ```

2. **Look for Connection Messages**: In the log output, look for messages indicating that Mosquitto has started and is connected to the seedbox.


## Testing

### Setting Execute Permissions

Ensure the script files have execute permissions:

```sh
chmod 755 ~/.Q4D/*.sh  # On the server
chmod 755 /mnt/user/appdata/Q4D/*.sh  # On unraid
```

### Initiating a Download

On the server, use the following command to initiate a download:

```sh
~/.Q4D/Queue4Download.sh "TorrentName" Hash Category Tracker "FullPath"
```

#### Example:

```sh
~/.Q4D/Queue4Download.sh "linuxmint-21.3-cinnamon-64bit.iso" 5aa5483aee76df2eae84ca4109adbc0d0702ab46 Software udp://tracker.opentrackr.org:1337/announce "/home/USERNAME/files/torrents/Software/linuxmint-21.3-cinnamon-64bit.iso"
```

This command should start the download of the ISO on unraid and add the tags `QUEUED` and then `DONE` in your torrent client.
