FROM alpine:latest
CMD ["sh", "-c", "echo Alpine on Render is running && tail -f /dev/null"]
EXPOSE 8080