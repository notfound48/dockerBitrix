# Используем за основу контейнера Ubuntu 14.04 LTS
FROM ubuntu:14.04

# Переключаем Ubuntu в неинтерактивный режим
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

# Устанавливаем локаль
RUN locale-gen ru_RU.UTF-8 && dpkg-reconfigure locales 

#Создать пользователя webmaster
RUN useradd -u 5678 webmaster

# Устанавливаем пакеты
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y nginx php5-fpm php5-mysql php5-gd php5-curl php-pear php-apc php5-mcrypt php5-imagick php5-memcache supervisor mysql-server wget curl mc nano openssh-server htop

# Настройка SSHd
RUN mkdir /var/run/sshd
RUN echo "root:root" | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Установка root пароля MySQL
ADD set-mysql-password.sh /tmp/set-mysql-password.sh
RUN /bin/sh /tmp/set-mysql-password.sh

# Очистка пакетов
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Запускаем supervisor
CMD ["/usr/bin/supervisord"] 