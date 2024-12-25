# Use the official Alpine image
FROM alpine:latest

# Install necessary packages, including ttyd
RUN apk update && apk add --no-cache bash curl ttyd

# Expose the port for the web terminal (8080)
EXPOSE 8080

# Ensure ttyd is set to run with a proper terminal (set -i for interactive)
CMD ttyd -p 8080 --no-daemon sh