FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache \
    sudo \
    git \
    curl \
    zsh \
    python3 \
    py3-pip \
    shadow \
    busybox-suid \
    nano \
    knock \
    iptables \
    openssh

# Create user 'ziro' with home directory and password
RUN useradd -m ziro && \
    echo "ziro:Oracle1010" | chpasswd

# Add user to 'wheel' group for sudo privileges
RUN echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers && \
    addgroup ziro wheel

RUN ssh-keygen -A

# Create the vulnerable temp directory
RUN mkdir -p /tmp/test_temp

# Copy the script

COPY cleanup_temp.py /usr/local/bin/cleanup_temp.py

COPY knockd.conf /etc/knockd.conf

COPY startup.sh /

# Deliberately unsafe permission — simulates a vulnerability
RUN chmod 777 /usr/local/bin/cleanup_temp.py && \
    chmod +x /usr/local/bin/cleanup_temp.py

# Add cron job to root's crontab
RUN echo "* * * * * /usr/bin/python3 /usr/local/bin/cleanup_temp.py >> /var/log/cleanup.log 2>&1" >> /etc/crontabs/root

# Create log file (also writable for demonstration if desired)
RUN touch /var/log/cleanup.log


# Set default shell to zsh (optional)
SHELL ["/bin/zsh", "-c"]

# Run cron in foreground
CMD ["crond", "-f", "-l", "2"]

