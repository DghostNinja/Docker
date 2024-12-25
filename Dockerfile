# Dockerfile
FROM alpine:latest

LABEL maintainer="your_email@example.com"

# Install necessary tools: bash, curl, busybox-extras (for HTTP server)
RUN apk update && apk add --no-cache bash curl busybox-extras

# Expose port 8080
EXPOSE 8080

# Create a simple HTML page for interaction
RUN echo "<h1>Alpine Web Shell</h1><form method='POST' action='/cmd'><input name='cmd' placeholder='Enter command'><button type='submit'>Run</button></form>" > /www/index.html

# Start BusyBox HTTP server on port 8080
CMD ["sh", "-c", "httpd -f -p 0.0.0.0:8080 -h /www && tail -f /dev/null"]