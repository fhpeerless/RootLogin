#!/bin/bash
sudo apt-get update

# 需要以sudo权限运行脚本
 if [[ $EUID -ne 0 ]]; then
     echo "本脚本需要root权限，请以sudo运行。"
     exit 1
 fi

# 修改/etc/ssh/sshd_config文件
SSHD_CONFIG="/etc/ssh/sshd_config"

# 设置PermitRootLogin为yes
sudo sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' $SSHD_CONFIG
sudo sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' $SSHD_CONFIG

# 设置PasswordAuthentication为yes
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' $SSHD_CONFIG
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' $SSHD_CONFIG



# 重启SSH服务
if [[ $(systemctl) =~ -\.mount ]]; then
    systemctl restart ssh
else
    /etc/init.d/ssh restart
fi

echo "SSH配置已更新，并重启了SSH服务。密码Ashagw"

echo "请设置登录密码：（输入两次，输入后的密码看不见）。"
PASSWORD="Ashagw123"
echo -e "$PASSWORD\n$PASSWORD" | sudo passwd root
