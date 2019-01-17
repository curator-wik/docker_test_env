#!/bin/bash
# Extract everything.
cd /
umask 0022
tar -xf files.tar

ln -s /usr/local/bin/phpunit-5.5.4.phar /usr/local/bin/phpunit-5.5

# The www-data user was arbitrarily chosen to run the tests; make it more amenable to usage.
usermod -d /home/www-data -s /bin/bash www-data

adduser --disabled-password --gecos 'FTP Test' ftptest
echo 'ftptest:Asdf1234' | chpasswd
mkdir /home/ftptest/www && chown ftptest:ftptest /home/ftptest/www && chmod 0755 /home/ftptest/www
mkdir -p /home/ftptest/world_writable_test_location/existing_dir && chown -R ftptest:ftptest /home/ftptest/world_writable_test_location && chmod -R 0777 /home/ftptest/world_writable_test_location
echo 'a file' >  /home/ftptest/world_writable_test_location/existing_file && chmod 0777 /home/ftptest/world_writable_test_location/existing_file

adduser --disabled-password --gecos 'FTP Test Chroot' ftptest_chroot
echo 'ftptest_chroot:Asdf1234' | chpasswd
mkdir /home/ftptest_chroot/www && chown ftptest_chroot:ftptest_chroot /home/ftptest_chroot/www && chmod 0755 /home/ftptest_chroot/www



# Make the user's home directory owned by root, so it is not writable by ftptest and vsftpd will chroot it
chown root:root /home/ftptest_chroot

ln -s /home/ftptest/www /home/ftptest/good_dirlink
touch /home/ftptest/a_file
ln -s /home/ftptest/a_file /home/ftptest/good_filelink
