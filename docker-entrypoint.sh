#!/bin/sh
set -e

public_ip=$(curl -s https://api.ip.sb/ip -A Mozilla --ipv4) &
nat_ip=$(ip a | grep inet | grep -v 127.0.0.1 | grep -v inet6 | awk '{print $2}' | cut -d "/" -f1 | awk 'NR==1 {print $1}') &
nat_info="--nat-info ${nat_ip}:${public_ip}" &
cd /usr/bin &
./mtproto-proxy -u nobody -p $web_port -H $port -S $secret --aes-pwd proxy-secret proxy-multi.conf -M $workerman $tag_arg --domain $domain $nat_info &
echo -e "TG一键链接: https://t.me/proxy?server=${public_ip}&port=${port}&secret=${client_secret}"
