FROM phusion/baseimage:0.11

MAINTAINER csek06

VOLUME ["/config"]

RUN export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
apt-get update && \
apt-get install -y \
npm && \
npm install ethereum-hdwallet -g && \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
mkdir -p /etc/my_init.d

COPY firstrun.sh /etc/my_init.d/firstrun.sh

RUN chmod +x /etc/my_init.d/firstrun.sh