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

# Create supervisord configuration file  
RUN echo "[supervisord]\nnodaemon=true\nlogfile=/var/log/supervisor/supervisord.log\nlogfile_maxbytes=50MB\nlogfile_backups=10\nloglevel=info\npidfile=/var/run/supervisord.pid\n\n[include]\nfiles = /etc/supervisor.d/*.ini" > /etc/supervisord.conf  

# Configure SSH service  
RUN echo "[program:sshd]\ncommand=/usr/sbin/sshd -D\nautostart=true\nautorestart=true\nstderr_logfile=/var/log/sshd.err.log\nstdout_logfile=/var/log/sshd.out.log" > /etc/supervisor.d/sshd.ini  

# Configure ttyd service  
RUN echo "[program:ttyd]\ncommand=ttyd -p 8080 sh\nautostart=true\nautorestart=true\nstderr_logfile=/var/log/ttyd.err.log\nstdout_logfile=/var/log/ttyd.out.log" > /etc/supervisor.d/ttyd.ini  

# Expose ports for SSH and ttyd  
EXPOSE 22 8080  

# Start supervisord  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]