# Use the official Alpine image as the base
FROM alpine:latest

# Install mosquitto and lftp
RUN apk add --no-cache mosquitto lftp

# Set the working directory
WORKDIR /root/.Q4D

# Start command
CMD ["tail", "-f", "/dev/null"]
