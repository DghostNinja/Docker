# Use the official Alpine image
FROM alpine:latest

# Install necessary packages, including ttyd
RUN apk update && apk add --no-cache bash curl ttyd

# Expose the port for the web terminal (8080)
EXPOSE 8080

# Start the web-based terminal emulator (ttyd)
CMD echo 'Starting web terminal on port 8080' && ttyd sh