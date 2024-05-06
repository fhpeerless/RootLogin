#!/bin/bash

# 检查是否以 root 权限运行脚本
if [[ $EUID -ne 0 ]]; then
    echo "本脚本需要 root 权限，请以 sudo 运行。"
    exit 1
fi

# 更新系统包列表
if command -v apt-get >/dev/null; then
    apt-get update
elif command -v yum >/dev/null; then
    yum update
fi

# 修改 /etc/ssh/sshd_config 文件
SSHD_CONFIG="/etc/ssh/sshd_config"

# 设置 PermitRootLogin 为 yes
sed -i 's/^PermitRootLogin no/PermitRootLogin yes/' $SSHD_CONFIG
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' $SSHD_CONFIG

# 设置 PasswordAuthentication 为 yes
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' $SSHD_CONFIG
sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' $SSHD_CONFIG

# 重启 SSH 服务
if systemctl is-active --quiet sshd; then
    systemctl restart sshd
elif [[ -f /etc/init.d/sshd ]]; then
    /etc/init.d/sshd restart
elif systemctl is-active --quiet ssh; then
    systemctl restart ssh
elif [[ -f /etc/init.d/ssh ]]; then
    /etc/init.d/ssh restart
fi

echo "SSH 配置已更新，并重启了 SSH 服务。"

# 设置 root 密码
echo "自动设置密码为ashagw"
# 移除自动设置密码的行，因为这不安全
PASSWORD="ashagw"
echo -e "$PASSWORD\n$PASSWORD" | passwd root