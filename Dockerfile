# Use the official Alpine image
FROM alpine:latest

# Install necessary packages, including ttyd and supervisor
RUN apk update && apk add --no-cache bash curl ttyd supervisor

# Create necessary directories for supervisor logs and configuration
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

# Create the ttyd supervisor configuration with explicit echo to avoid multiline issues
RUN echo "[program:ttyd]" > /etc/supervisor.d/ttyd.ini && \
    echo "command=/usr/bin/ttyd -p 8080 sh" >> /etc/supervisor.d/ttyd.ini && \
    echo "autostart=true" >> /etc/supervisor.d/ttyd.ini && \
    echo "autorestart=true" >> /etc/supervisor.d/ttyd.ini && \
    echo "stderr_logfile=/var/log/ttyd.err.log" >> /etc/supervisor.d/ttyd.ini && \
    echo "stdout_logfile=/var/log/ttyd.out.log" >> /etc/supervisor.d/ttyd.ini

# Verify configuration files
RUN ls -l /etc/supervisor.d/ && cat /etc/supervisord.conf

# Expose ttyd port
EXPOSE 8080

# Start supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]