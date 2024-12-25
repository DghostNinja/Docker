# Use Alpine Linux as the base image
FROM alpine:latest

# Install basic utilities (optional)
RUN apk update && apk add bash curl

# Set a default command
CMD ["sh"]
FROM alpine:latest
CMD ["sh", "-c", "echo 'Alpine on Render is running' && tail -f /dev/null"]
EXPOSE 8080
