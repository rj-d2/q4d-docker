# Use the official Alpine image as the base
FROM alpine:latest

# Install mosquitto, mosquitto_sub, lftp, bash, nano, and openssh
RUN apk add --no-cache mosquitto mosquitto-clients lftp bash nano openssh

# Set the working directory
WORKDIR /root/.Q4D

# Start command
#CMD ["tail", "-f", "/dev/null"]
CMD ["bash", "-xv", "./ProcessEvent.sh"]
