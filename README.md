# Docker образ Bitrix

## Установка Docker
```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

sudo sh -c "echo deb https://get.docker.com/ubuntu docker main \
 > /etc/apt/sources.list.d/docker.list"

sudo apt-get update

sudo apt-get install lxc-docker
```
## Разворачивание
```
sudo adduser -u 5678 webmaster

cd /home/webmaster/

git clone https://github.com/notfound48/dockerBitrix.git && cd dockerBitrix

sudo docker build -t bitrix ./

sudo cp -R /home/webmaster/dockerBitrix/data/ \
/home/webmaster/dockerBitrix/logs/ \
/home/webmaster/dockerBitrix/configs/ \
/home/webmaster/

cd /home/webmaster/

mkdir data/mysql

sudo chown -R webmaster:webmaster data/www/

sudo docker run -t -i -d \
-v "$(pwd)/logs:/logs" \
-v "$(pwd)/data/www:/www" \
-v "$(pwd)/data/mysql:/var/lib/mysql" \
-v "$(pwd)/configs/nginx/:/etc/nginx" \
-v "$(pwd)/configs/php5:/etc/php5" \
-v "$(pwd)/configs/mysql:/etc/mysql" \
-v "$(pwd)/configs/zabbix:/etc/zabbix" \
-v "$(pwd)/configs/cron:/etc/cron.d/docker" \
-v "$(pwd)/configs/supervisord.conf:/etc/supervisor/conf.d/supervisord.conf" \
-p 80:80 \
-p 443:443 \
-p 4444:22 \
-p 10055:10050 \
--name bitrix bitrix
```
## Доступ по умолчанию
```
SSH access to the container: ssh -p 4444 root@server_address | QWlOZ88modPzqaKB
```
## Zabbix мониторинг
```
Port 10055
```
```
В макросы узла добавить:

{$NGINX_STATS_URL} = http://127.0.0.1:8888/nginx_status
{$PHP_FPM_STATUS_URL} = http://127.0.0.1/php-fpm_status
```