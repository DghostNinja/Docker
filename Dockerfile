# Use the official Alpine image
FROM alpine:latest

# Install necessary packages, including ttyd and SSH
RUN apk update && apk add --no-cache bash curl openssh ttyd

# Set up SSH
RUN ssh-keygen -A
RUN echo "root:Docker!" | chpasswd

# Expose ports for SSH and the web terminal
EXPOSE 22 8080

# Start the SSH server and the web-based terminal emulator (ttyd)
CMD /usr/sbin/sshd && echo 'Web terminal and SSH server started' && ttyd sh