# Dockerfile
# Use the official Alpine image
FROM alpine:latest

# Maintainer information
LABEL maintainer="your_email@example.com"

# Update and install essential packages
RUN apk update && apk add --no-cache bash curl

# Expose a default port (e.g., 8080)
EXPOSE 8080

# Keep the container alive with a long-running process
CMD ["sh", "-c", "while true; do echo 'Alpine Linux is running...'; sleep 60; done"]