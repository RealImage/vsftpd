# VSFTPD Container Image

[![Release 🚀](https://github.com/RealImage/vsftpd/actions/workflows/release.yml/badge.svg)](https://github.com/RealImage/vsftpd/actions/workflows/release.yml)

A simple FTP server, using
[`vsftpd`](https://security.appspot.com/vsftpd.html).

## How to use this image

### start a FTP Server instance

To start a container, with data stored in `/data` on the host, use the
following:

```sh
podman build -t vsftpd .
podman run \
  --detach \
  --env FTP_PASS=123 \
  --env FTP_USER=user \
  --name my-ftp-server \
  --publish 20-21:20-21/tcp \
  --publish 40000-40009:40000-40009/tcp \    # For passive mode transfers
  --volume users.txt:/etc/vsftpd/users.txt \ # Add virtual users
  --volume /data:/home/user \
  vsftpd
```

The users.txt file should contain an even number of lines, with each pair
representing a username and password. For example:

```txt
user1
password1
user2
password2
```
