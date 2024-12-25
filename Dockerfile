# Dockerfile
# Use the official Alpine image
FROM alpine:latest

# Set a maintainer
LABEL maintainer="your_email@example.com"

# Update and install basic utilities
RUN apk update && apk add --no-cache bash curl

# Set the default command
CMD ["/bin/sh"]
