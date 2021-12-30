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

# java
RUN apt search openjdk \
    && apt-get -y install openjdk-11-jdk

# download and add repository key
RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -

# getting binary file into /etc/apt/sources.list.d
RUN sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# updating packages
RUN apt-get update

# installing Jenkins
RUN apt-get -y install jenkins

# creating and changing home folder
RUN mkdir /var/jenkins; sed -i -e 's/\/var\/lib/\/var/g' /etc/default/jenkins

# ansible install
RUN add-apt-repository --yes --update ppa:ansible/ansible
RUN apt-get install -y \
    mc \
    ansible \
    net-tools
RUN apt-get install -y \
    telnet \
    iputils-ping

# ssh
COPY ssh/* /root/.ssh/

# set rights, start jenkins and enless sleep for continuation work
CMD chmod 600 ~/.ssh/*; \
    chmod -R 775 /var/jenkins; \
    chown -R jenkins:jenkins /var/jenkins; \
    service jenkins start; \
    sleep infinity