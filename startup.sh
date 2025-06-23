#/bin/sh
crond restart
/usr/sbin/sshd
iptables -A INPUT -p tcp --dport 22 -j DROP
knockd -d -c /etc/knockd.conf
