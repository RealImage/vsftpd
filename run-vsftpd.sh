#!/bin/bash

# Create home dir and update vsftpd user db:
mkdir -p "/home/vsftpd/ftp"
chown -R ftp:ftp /home/vsftpd/

/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db

sed -i "s/^pasv_address.*/pasv_address=${PASV_ADDRESS}/" /etc/vsftpd/vsftpd.conf

# Run vsftpd:
&>/dev/null /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
