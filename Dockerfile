FROM phusion/baseimage:18.04-1.0.0-amd64

VOLUME ["/config"]

RUN export DEBCONF_NONINTERACTIVE_SEEN=true DEBIAN_FRONTEND=noninteractive && \
apt-get update && \
apt-get install -y \
tzdata python3-pip && \
pip3 install aiohttp motor pbkdf2 pymongo dnspython hdwallet web3 google-cloud-bigquery && \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
mkdir -p /etc/my_init.d

COPY firstrun.sh /etc/my_init.d/firstrun.sh

RUN chmod +x /etc/my_init.d/firstrun.sh