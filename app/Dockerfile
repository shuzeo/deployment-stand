FROM ubuntu:20.04

# noninteractive mode
ENV DEBIAN_FRONTEND noninteractive

# installing packages and utilities
RUN apt-get -y update \
    && apt-get -y install software-properties-common git gnupg sudo nano vim wget curl zip unzip \
    build-essential libtool autoconf uuid-dev pkg-config libsodium-dev lynx-common tcl \
    inetutils-ping net-tools ssh openssh-server openssh-client openssl letsencrypt \
    apt-transport-https telnet locales gdebi lsb-release \
    && apt-get clean

# install required applications
RUN apt-get update && apt-get install -y \
    mc \
    net-tools \
    openssh-server

# ssh settings
COPY ssh/sshd_config /etc/ssh/
COPY ssh/authorized_keys /root/.ssh/

# ssh start enless sleep for continuation work
CMD chmod 600 ~/.ssh/*; \
    /etc/init.d/ssh start

CMD ["/usr/sbin/init"]