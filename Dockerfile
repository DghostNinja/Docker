# Use the official Alpine image  
FROM alpine:latest  

# Install necessary packages, including ttyd and SSH  
RUN apk update && apk add --no-cache bash curl openssh ttyd  

# Set root password for SSH (not secure, change for production)  
RUN echo "root:Docker!" | chpasswd  

# Generate SSH host keys  
RUN ssh-keygen -A  

# Expose ports for SSH and the web terminal  
EXPOSE 22 8080  

# Start both SSH and ttyd in parallel using supervisord  
RUN apk add --no-cache supervisor  

# Create supervisord configuration  
RUN mkdir -p /etc/supervisor.d  
RUN echo "[program:sshd]\ncommand=/usr/sbin/sshd -D\nautostart=true\nautorestart=true\nstderr_logfile=/var/log/sshd.err.log\nstdout_logfile=/var/log/sshd.out.log" > /etc/supervisor.d/sshd.ini  
RUN echo "[program:ttyd]\ncommand=ttyd -p 8080 sh\nautostart=true\nautorestart=true\nstderr_logfile=/var/log/ttyd.err.log\nstdout_logfile=/var/log/ttyd.out.log" > /etc/supervisor.d/ttyd.ini  

# Default command to run supervisord  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]