# Docker image for Bitrix

Docker образ для разворачивания типового окружения для Bitrix
# Разворачивание

1. git clone https://github.com/notfound48/dockerBitrix.git && cd dockerBitrix
2. useradd -u 5678 webmaster
3. chown -R webmaster:webmaster data/www/
4. docker build -t bitrix ./
5. < docker run -t -i -d \
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
--name bitrix bitrix >
