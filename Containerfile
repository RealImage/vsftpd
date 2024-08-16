FROM docker.io/library/debian:stable-slim

ARG USER_ID=1400
ARG GROUP_ID=1450

RUN apt-get update \
  && apt-get install -yqq -o=Dpkg::Use-Pty=0 vsftpd db-util \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /tmp/vsftpd/empty

RUN usermod -u ${USER_ID} ftp
RUN groupmod -g ${GROUP_ID} ftp

ENV PASV_ADDRESS **IPv4**

COPY vsftpd.conf /etc/vsftpd/
COPY vsftpd_virtual /etc/pam.d/
COPY run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/

VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

EXPOSE 3321

CMD ["/usr/sbin/run-vsftpd.sh"]
