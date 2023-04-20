FROM redis:6.2.12-alpine3.17 

COPY redis.conf /usr/local/etc/redis/redis.conf
USER redis
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
