# Nginx & ngx_lua
# for
#   fuelPHP
#   Single host application
# 
# docker run -itd -p 80:80 -p 443:443 --link [php5-fpmコンテナ]:php5-fpm nginx

FROM ubuntu:14.04
MAINTAINER zanenform

# Install Nginx.
RUN apt-get -y update && apt-get install -y nginx-extras lua-nginx-redis

# Nginx Config.
RUN chown -R www-data:www-data /var/lib/nginx && \
  sed -i '1s/^/daemon off;\n/' /etc/nginx/nginx.conf && \
  sed -i '1s/^/env PHP5-FPM;\n/' /etc/nginx/nginx.conf

COPY fuelphp-conf /etc/nginx/sites-available/default

# Expose ports.
EXPOSE 80 443

# Define default command.
# docker run --linkから環境変数の値を渡すために、引数は利用しない
CMD ["/usr/sbin/nginx"]
