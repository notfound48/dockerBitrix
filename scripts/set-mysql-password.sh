/usr/sbin/mysqld &
sleep 10

# Создали root пользователя с паролем: sbOIp59bkFRLhswE
# Создали пользователя zabbix с паролем GbfnJkYQuxsgn8X5
# И проставляем часовой пояс как в контейнере
echo "GRANT ALL PRIVILEGES ON *.* TO root@'%' IDENTIFIED BY 'sbOIp59bkFRLhswE'; \
 GRANT ALL PRIVILEGES ON *.* TO 'zabbix'@'localhost' IDENTIFIED BY 'GbfnJkYQuxsgn8X5'; \
 FLUSH PRIVILEGES; \
 SET GLOBAL time_zone = 'SYSTEM'; \
 SET time_zone = 'SYSTEM';" | mysql