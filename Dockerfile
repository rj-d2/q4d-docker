# Use the official Alpine image as the base
FROM alpine:latest

# Install nano, mosquitto_sub, bash, mosquitto, and lftp
RUN apk add --no-cache nano mosquitto-clients bash mosquitto lftp

# Set the working directory
WORKDIR /root/.Q4D

# Start command
#CMD ["tail", "-f", "/dev/null"]
CMD ["bash", "-xv", "./ProcessEvent.sh"]
