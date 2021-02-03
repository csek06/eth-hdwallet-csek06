FROM phusion/baseimage:18.04-1.0.0-amd64

VOLUME ["/config"]

RUN export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
apt-get update && \
apt-get install -y \
tzdata nodejs npm python3-pip git && \
npm install ethereum-hdwallet -g && \
npm install --save eth-balance-checker && \
pip3 install pbkdf2 pymongo pyetherbalance dnspython && \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
mkdir -p /etc/my_init.d

COPY firstrun.sh /etc/my_init.d/firstrun.sh

RUN chmod +x /etc/my_init.d/firstrun.sh