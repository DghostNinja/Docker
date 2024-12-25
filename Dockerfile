# Dockerfile
FROM alpine:latest

LABEL maintainer="your_email@example.com"

# Install necessary tools and Gotty
RUN apk update && apk add --no-cache bash curl build-base go && \
    go install github.com/yudai/gotty@latest

# Expose HTTP port
EXPOSE 8080

# Start Gotty for web terminal
CMD ["/root/go/bin/gotty", "-w", "-p", "8080", "sh"]