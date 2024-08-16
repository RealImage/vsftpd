FROM docker.io/library/alpine:3.20.2
ENV FTP_USER=test \
    FTP_PASS=test \
    GID=1000 \
    UID=1000

RUN apk add --no-cache --update \
	vsftpd==3.0.5-r2

COPY /src/vsftpd.conf /etc/vsftpd
COPY /src/vsftpd_users /etc/pam.d
COPY /src/entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
EXPOSE 20/tcp 21/tcp 40000-40009/tcp
