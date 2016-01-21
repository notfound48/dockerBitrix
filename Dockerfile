FROM ubuntu:14.04

MAINTAINER Bezrukavnikov Ilya “just_bis@mail.ru”

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales 

RUN echo Europe/Moscow > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN useradd -u 5678 webmaster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y nginx php5-fpm php5-mysql php5-gd php5-curl php-pear php-apc php5-mcrypt php5-imagick php5-memcache supervisor mysql-server wget curl mc nano openssh-server htop sendmail memcached zabbix-agent

RUN mkdir /var/run/sshd
RUN echo "root:QWlOZ88modPzqaKB" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

ADD /scripts/mysql_start.sh /root/mysql_start.sh

RUN rm -rf /var/lib/mysql

# Скрипт правки hosts (для sendmail)
ADD /scripts/change-hosts.sh /root/change-hosts.sh

# Очистка пакетов
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Запускаем supervisor
CMD ["/usr/bin/supervisord"] 