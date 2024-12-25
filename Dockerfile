# Dockerfile
# Use the official Alpine image
FROM alpine:latest

# Maintainer information
LABEL maintainer="your_email@example.com"

# Update and install essential packages
RUN apk update && apk add --no-cache bash curl

# Expose the port Render expects (e.g., 8080)
EXPOSE 8080

# Start a simple HTTP server to keep the container alive
CMD ["sh", "-c", "echo 'Starting HTTP server on port 8080' && while true; do echo -e 'HTTP/1.1 200 OK\n\nAlpine is running' | nc -l -p 8080; done"]