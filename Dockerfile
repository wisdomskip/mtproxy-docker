FROM alpine:latest

LABEL maintainer="wisdom <wisdom2622069252@gmail.com>"

ENV web_port=8888 \
    port= \
    secret= \
    tag= \
    domain=hostloc.com
    
RUN apk add --no-cache curl iproute2 wget \
    &&  cd /usr/bin \
    &&  wget https://raw.githubusercontent.com/wisdomskip/mtproxy-docker/main/amd64/mtproto-proxy -O mtproto-proxy -q \
    &&  chmod +x mtproto-proxy \
    &&  curl -s https://core.telegram.org/getProxySecret -o proxy-secret \
    &&  curl -s https://core.telegram.org/getProxyConfig -o proxy-multi.conf \
    &&  domain_hex=$(xxd -pu <<<$domain | sed 's/0a//g') \
    &&  client_secret="ee${secret}${domain_hex}"
    
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod 775 usr/local/bin/docker-entrypoint.sh  \
    &&  ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
