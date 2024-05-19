# RootLogin
由于在各大云服务商那里开出来的服务器不支持密码登录每次一个一个敲命令很费劲，所以写成了一键脚本，方便一键设置密码登录.
# ubuntu
sudo wget -N --no-check-certificate -O /rootssh.sh https://raw.githubusercontent.com/fhpeerless/RootLogin/main/rootssh.sh && sudo chmod 777 /rootssh.sh && sudo bash /rootssh.sh
