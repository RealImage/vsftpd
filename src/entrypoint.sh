#!/bin/sh

addgroup \
  -g "$GID" \
  -S \
  "$FTP_USER"

adduser \
  -D \
  -G "$FTP_USER" \
  -h /home/"$FTP_USER" \
  -s /bin/false \
  -u "$UID" \
  "$FTP_USER"

# Create the virtual user database
touch /etc/vsftpd/users.txt
/usr/bin/db_load -T -t hash -f /etc/vsftpd/users.txt /etc/vsftpd/users.db

# Set pasv_address from the environment variable
if [ "$PUBLIC_HOST" != "" ]; then
  echo "Setting pasv_address to $PUBLIC_HOST"
  sed -i "s/^pasv_address.*/pasv_address=${PUBLIC_HOST}/" /etc/vsftpd/vsftpd.conf
fi

mkdir -p /home/"$FTP_USER"
chown -R "$FTP_USER:$FTP_USER" /home/"$FTP_USER"
echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

touch /var/log/vsftpd.log
tail -f /var/log/vsftpd.log | tee /dev/stdout &
touch /var/log/xferlog
tail -f /var/log/xferlog | tee /dev/stdout &

/usr/sbin/vsftpd
