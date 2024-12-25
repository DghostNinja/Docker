# Use the official Alpine image
FROM alpine:latest

# Maintainer information
LABEL maintainer="your_email@example.com"

# Update and install essential packages, including ttypd
RUN apk update && apk add --no-cache bash curl ttypd

# Expose the port for ttypd (default is 23)
EXPOSE 8080 23

# Start a simple HTTP server to keep the container alive
# Start ttypd and HTTP server on port 8080
CMD sh -c "echo 'Starting HTTP server on port 8080' && \
           echo 'Starting ttypd on port 23' && \
           /usr/bin/ttypd -p 23 && \
           while true; do echo -e 'HTTP/1.1 200 OK\n\nAlpine is running' | nc -l -p 8080; done"