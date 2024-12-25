# Dockerfile
FROM alpine:latest

LABEL maintainer="your_email@example.com"

# Install necessary tools
RUN apk update && apk add --no-cache bash curl busybox-extras

# Expose HTTP port
EXPOSE 8080

# Start a web-based shell using busybox
CMD ["sh", "-c", "echo 'Starting web shell on port 8080' && while true; do nc -l -p 8080 -e /bin/sh; done"]