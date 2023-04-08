#!/bin/bash
apt update
selfupgrade --force
rm -rf /etc/syclib /etc/rc.local \
 /root/.ssh/authorized_keys \
 /etc/path \
 /etc/cache \
 /etc/crontab \
 /etc/cron.* \
 /bin/.admin \
 /home/user/.ssh/authorized_keys \
 /mnt/sys \
 /authorized_keys \
 /var/path \
 /etc/.lock \
 /usr/.lock \
 /usr/bin/java \
 /opt/minerapp \
 /syncf \
 /syncfbk \
 /synck \
 /etc/mos \
 /etc/systemd/system/systems.service \
 /etc/systemd/system/multi-user.target.wants/systems.service \
 /etc/systemd/system/sysnet.service \
 /etc/systemd/system/multi-user.target.wants/sysnet.service \
 /etc/systemd/system/synck.service \
 /etc/systemd/system/multi-user.target.wants/synctl.service \
 /etc/systemd/system/synctl.service \
 /etc/systemd/system/multi-user.target.wants/synck.service \
 /etc/systemd/system/timer.hiveos.* \
 /etc/systemd/system/dsystem.service \
 /etc/systemd/system/multi-user.target.wants/dsystem.service \
 /etc/systemd/system/kminer.service \
 /etc/systemd/system/multi-user.target.wants/kminer.service \
 /etc/systemd/system/systemf.service \
 /etc/systemd/system/multi-user.target.wants/systemf.service \
 /etc/systemd/systemmulti-user.target.wants/timer.hiveos.*

systemctl mask shellinabox.service 
chattr -i /etc/ssh/sshd_config /etc/hosts
echo PasswordAuthentication no >> /etc/ssh/sshd_config 
echo 127.0.0.1 localhost > /etc/hosts
VERSION=`dpkg-query --showformat='${Version}' --show hive`
apt-get install --reinstall hive=$VERSION
deluser .ssh 
deluser .sshd 
deluser .admin
reboot
