# Nginx & ngx_lua
# for
#   fuelPHP
#   Single host application
#
# docker run -itd -p 80:80 -p 443:443 --link [php5-fpmコンテナ]:php5-fpm -e "FUEL_ENV=[local|development|production|...]" nginx

FROM ubuntu:14.04
MAINTAINER zanenform

# Install Nginx.
RUN apt-get -y update && apt-get install -y nginx-extras lua-nginx-redis

# Nginx Config.
RUN chown -R www-data:www-data /var/lib/nginx && \
  sed -i '1s/^/daemon off;\n/' /etc/nginx/nginx.conf && \
  sed -i '1s/^/env PHP5_FPM_PORT_9000_TCP_ADDR;\n/' /etc/nginx/nginx.conf && \
  sed -i '1s/^/env FUEL_ENV;\n/' /etc/nginx/nginx.conf

COPY fuelphp-conf /etc/nginx/sites-available/default

# Expose ports.
EXPOSE 80 443

# Define default command.
CMD ["/usr/sbin/nginx"]
