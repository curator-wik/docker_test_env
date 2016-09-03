FROM prophusion/prophusion-base
MAINTAINER Mike Baynton <mike@mbaynton.com>

RUN apt-get update

RUN apt-get install -y vsftpd ftp && apt-get clean

COPY vsftpd.conf /etc/vsftpd.conf
COPY vsftpd /etc/init.d/vsftpd

RUN adduser --disabled-password --gecos 'FTP Test' ftptest
RUN echo 'ftptest:Asdf1234' | chpasswd
# Make the user's home directory owned by root, so it is not writable by ftptest and vsftpd will chroot it
RUN chown root:root /home/ftptest

EXPOSE 21
