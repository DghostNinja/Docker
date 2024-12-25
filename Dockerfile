FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache bash curl openssh

# Set up SSH
RUN ssh-keygen -A
RUN echo "root:Docker!" | chpasswd

# Expose port for SSH and the web server
EXPOSE 22 8080

# Start SSH server and HTTP server
CMD /usr/sbin/sshd && echo 'HTTP server started' && while true; do echo -e 'HTTP/1.1 200 OK\n\nAlpine is running' | nc -l -p 8080; done