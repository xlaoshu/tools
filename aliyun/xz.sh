#!/bin/bash
if ps aux | grep -i '[a]liyun'; then
    wget http://update.aegis.aliyun.com/download/uninstall.sh
    chmod +x uninstall.sh
    ./uninstall.sh
    wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
    chmod +x quartz_uninstall.sh
    ./quartz_uninstall.sh
    rm -f uninstall.sh quartz_uninstall.sh
    pkill aliyun-service
    rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
    rm -rf /usr/local/aegis*;
    elif ps aux | grep -i '[y]unjing'; then
    /usr/local/qcloud/stargate/admin/uninstall.sh
    /usr/local/qcloud/YunJing/uninst.sh
    /usr/local/qcloud/monitor/barad/admin/uninstall.sh
fi

# 卸载安骑士
wget http://update.aegis.aliyun.com/download/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
wget http://update.aegis.aliyun.com/download/quartz_uninstall.sh
chmod +x quartz_uninstall.sh
./quartz_uninstall.sh

# 删除残留
pkill aliyun-service
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*

# 腾讯云
./usr/local/qcloud/stargate/admin/uninstall.sh
./usr/local/qcloud/YunJing/uninst.sh
./usr/local/qcloud/monitor/barad/admin/uninstall.sh

# 阿里云
systemctl stop aliyun
systemctl disable aliyun
rm -rf /etc/systemd/system/aliyun.service
rm -rf /usr/sbin/aliyun_installer
rm -rf /usr/sbin/aliyun-service
rm -rf /usr/local/share/aliyun-assist
systemctl daemon-reload

systemctl stop AssistDaemon
systemctl disable AssistDaemon
rm -rf /etc/systemd/system/AssistDaemon.service
rm -rf /usr/local/share/assist-daemon
systemctl daemon-reload

 ps -ef | grep -v grep | grep -i aliyun | awk '{print $8}'
 ps -ef | grep -v grep | grep -i aliyun | awk '{print $2}' | xargs kill -9
systemctl stop aegis.service
service aegis stop  #停止服务
chkconfig --del aegis  # 删除服务
iptables -I INPUT -s 140.205.201.0/28 -j DROP
iptables -I INPUT -s 140.205.201.16/29 -j DROP
iptables -I INPUT -s 140.205.201.32/28 -j DROP
iptables -I INPUT -s 140.205.225.192/29 -j DROP
iptables -I INPUT -s 140.205.225.200/30 -j DROP
iptables -I INPUT -s 140.205.225.184/29 -j DROP
iptables -I INPUT -s 140.205.225.183/32 -j DROP
iptables -I INPUT -s 140.205.225.206/32 -j DROP
iptables -I INPUT -s 140.205.225.205/32 -j DROP
iptables -I INPUT -s 140.205.225.195/32 -j DROP
iptables -I INPUT -s 140.205.225.204/32 -j DROP
rm -rf uninstall.sh
wget "http://update2.aegis.aliyun.com/download/uninstall.sh" && chmod +x uninstall.sh && ./uninstall.sh
rm -rf uninstall.sh
# wget "http://update.aegis.aliyun.com/download/uninstall.sh" && chmod +x uninstall.sh && ./uninstall.sh
# rm -rf uninstall.sh
wget https://raw.githubusercontent.com/xlaoshu/tools/refs/heads/main/aliyun/uninstall.sh
chmod +x uninstall.sh
./uninstall.sh
wget https://raw.githubusercontent.com/xlaoshu/tools/refs/heads/main/aliyun/quartz_uninstall.sh
chmod +x quartz_uninstall.sh
./quartz_uninstall.sh
pkill aliyun-service
rm -fr /etc/init.d/agentwatch /usr/sbin/aliyun-service
rm -rf /usr/local/aegis*
rm -rf uninstall.sh
rm -rf quartz_uninstall.sh
