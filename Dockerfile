# Use the official Alpine image
FROM alpine:latest

# Maintainer information
LABEL maintainer="your_email@example.com"

# Update and install essential packages, including telnetd
RUN apk update && apk add --no-cache bash curl inetutils

# Expose the port for telnet (default is 23) and HTTP (8080)
EXPOSE 8080 23

# Start a simple HTTP server to keep the container alive
# Start telnet server and HTTP server on port 8080
CMD sh -c "echo 'Starting HTTP server on port 8080' && \
           echo 'Starting telnet server on port 23' && \
           /usr/bin/telnetd -l /bin/sh && \
           while true; do echo -e 'HTTP/1.1 200 OK\n\nAlpine is running' | nc -l -p 8080; done"