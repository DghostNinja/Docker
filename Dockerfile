# Use the official Alpine image  
FROM alpine:latest  

# Install necessary packages  
RUN apk update && apk add --no-cache bash curl openssh ttyd supervisor  

# Set root password for SSH (change for production)  
RUN echo "root:Docker!" | chpasswd  

# Generate SSH host keys  
RUN ssh-keygen -A  

# Create necessary directories for supervisor logs  
RUN mkdir -p /var/log/supervisor  
RUN mkdir -p /etc/supervisor.d  

# Create supervisord main configuration file  
RUN echo "[supervisord]\n\
nodaemon=true\n\
logfile=/var/log/supervisor/supervisord.log\n\
logfile_maxbytes=50MB\n\
logfile_backups=10\n\
loglevel=info\n\
pidfile=/var/run/supervisord.pid\n\
[include]\n\
files = /etc/supervisor.d/*.ini" > /etc/supervisord.conf  

# Create SSH configuration for supervisor  
RUN echo "[program:sshd]\n\
command=/usr/sbin/sshd -D\n\
autostart=true\n\
autorestart=true\n\
stderr_logfile=/var/log/sshd.err.log\n\
stdout_logfile=/var/log/sshd.out.log" > /etc/supervisor.d/sshd.ini  

# Create ttyd configuration for supervisor  
RUN echo "[program:ttyd]\n\
command=ttyd -p 8080 sh\n\
autostart=true\n\
autorestart=true\n\
stderr_logfile=/var/log/ttyd.err.log\n\
stdout_logfile=/var/log/ttyd.out.log" > /etc/supervisor.d/ttyd.ini  

# Verify configurations  
RUN ls -l /etc/supervisor.d/ && cat /etc/supervisord.conf  

# Expose ports for SSH and ttyd  
EXPOSE 22 8080  

# Start supervisord  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]