# Docker image for Bitrix

## Instaling Docker
```
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
  --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
$ sudo sh -c "echo deb https://get.docker.com/ubuntu docker main \
 > /etc/apt/sources.list.d/docker.list"
$ sudo apt-get update
$ sudo apt-get install lxc-docker
```
## Deployment
```
$ git clone https://github.com/notfound48/dockerBitrix.git && cd dockerBitrix
```
```
$ sudo useradd -u 5678 webmaster
```
```
$ sudo chown -R webmaster:webmaster data/www/
```
```
$ sudo docker build -t bitrix ./
```
```
$ sudo docker run -t -i -d \
-v "$(pwd)/logs:/logs" \
-v "$(pwd)/data/www:/www" \
-v "$(pwd)/data/mysql:/var/lib/mysql" \
-v "$(pwd)/configs/nginx/:/etc/nginx" \
-v "$(pwd)/configs/php5:/etc/php5" \
-v "$(pwd)/configs/mysql:/etc/mysql" \
-v "$(pwd)/configs/cron:/var/spool/cron/crontabs" \
-v "$(pwd)/configs/memcached.conf:/etc/memcached.conf" \
-v "$(pwd)/configs/supervisord.conf:/etc/supervisor/conf.d/supervisord.conf" \
-p 80:80 \
-p 443:443 \
-p 4444:22 \
--name bitrix bitrix
```
