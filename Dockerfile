FROM prophusion/prophusion-base
MAINTAINER Mike Baynton <mike@mbaynton.com>

RUN apt-get update

RUN apt-get install -y vsftpd ftp && apt-get clean

COPY vsftpd.conf /etc/vsftpd.conf
COPY vsftpd.chroot_list /etc/vsftpd.chroot_list
COPY vsftpd /etc/init.d/vsftpd
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY phpunit-5.5.4.phar /usr/local/bin/phpunit-5.5.4.phar
RUN ln -s /usr/local/bin/phpunit-5.5.4.phar /usr/local/bin/phpunit-5.5

RUN adduser --disabled-password --gecos 'FTP Test' ftptest
RUN echo 'ftptest:Asdf1234' | chpasswd
RUN mkdir /home/ftptest/www && chown ftptest:ftptest /home/ftptest/www && chmod 0755 /home/ftptest/www

RUN adduser --disabled-password --gecos 'FTP Test Chroot' ftptest_chroot
RUN echo 'ftptest_chroot:Asdf1234' | chpasswd
RUN mkdir /home/ftptest_chroot/www && chown ftptest_chroot:ftptest_chroot /home/ftptest_chroot/www && chmod 0755 /home/ftptest_chroot/www

# Make the user's home directory owned by root, so it is not writable by ftptest and vsftpd will chroot it
RUN chown root:root /home/ftptest_chroot

EXPOSE 21

ENTRYPOINT ["/docker-entrypoint.sh"]