# Use the official Alpine image
FROM alpine:latest

# Install necessary packages
RUN apk update && apk add --no-cache bash curl openssh ttyd supervisor

# Set root password for SSH (change in production)
RUN echo "root:Docker!" | chpasswd

# Generate SSH host keys
RUN ssh-keygen -A

# Create necessary directories for supervisor logs and config
RUN mkdir -p /var/log/supervisor && mkdir -p /etc/supervisor.d

# Main Supervisord Configuration
RUN echo "[supervisord]\n\
nodaemon=true\n\
logfile=/var/log/supervisor/supervisord.log\n\
logfile_maxbytes=50MB\n\
logfile_backups=10\n\
loglevel=info\n\
pidfile=/var/run/supervisord.pid\n\
[include]\n\
files = /etc/supervisor.d/*.ini" > /etc/supervisord.conf

# SSH Configuration for Supervisor
RUN echo "[program:sshd]\n\
command=/usr/sbin/sshd -D\n\
autostart=true\n\
autorestart=true\n\
stderr_logfile=/var/log/sshd.err.log\n\
stdout_logfile=/var/log/sshd.out.log" > /etc/supervisor.d/sshd.ini

# ttyd Configuration for Supervisor
RUN echo "[program:ttyd]\n\
command=ttyd -p 8080 sh\n\
autostart=true\n\
autorestart=true\n\
stderr_logfile=/var/log/ttyd.err.log\n\
stdout_logfile=/var/log/ttyd.out.log" > /etc/supervisor.d/ttyd.ini

# Verify configuration files
RUN ls -l /etc/supervisor.d/ && cat /etc/supervisord.conf

# Expose SSH and ttyd ports
EXPOSE 22 8080

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]