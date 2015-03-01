# Nginx & ngx_lua
# Purpose
#   Multi host application
#   fuelPHP
#
# Require
#   redis
#
# redis と連携することでマルチホストアプリケーションサーバーに対応します。
# docker run -itd -p 80:80 -p 443:443 --env REDISSERVER=192.168.59.103 nginx

FROM ubuntu:14.04
MAINTAINER zanenform

# Install Nginx.
RUN apt-get -y update && apt-get install -y nginx-extras lua-nginx-redis

# Nginx Config.
RUN sed -i '1s/^/daemon off;\n/' /etc/nginx/nginx.conf && \
  sed -i '1s/^/env PHP5-FPM;\n/' /etc/nginx/nginx.conf
COPY fuelphp-conf /etc/nginx/sites-available/default

# Install Redis cli.
RUN apt-get install -y redis-tools

# Expose ports.
EXPOSE 80 443

# Define default command.
# docker run から環境変数の値を渡すために、引数は利用しない
CMD ["/usr/sbin/nginx"]
