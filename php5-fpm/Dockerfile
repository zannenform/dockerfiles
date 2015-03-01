# php5-fpm
#
# php config: Asia/Tokyo
# 
# docker run -itd -p 9000:9000 -v <pool.d-dir>:/etc/php5/fpm/pool.d -v <html-dir>:/var/www php5-fpm

MAINTAINER zanenform

# Pull base image.
FROM dockerfile/ubuntu:14.04

# Install PHP-FPM.
RUN apt-get -y update && apt-get install -y php5-fpm php5-cli php5-json

# Set up PHP.
RUN echo "cgi.fix_pathinfo=0" > /etc/php5/fpm/conf.d/local.ini && \
  echo "date.timezone = Asia/Tokyo" >> /etc/php5/fpm/conf.d/local.ini && \
  mkdir /var/www

# Define mountable directories.
VOLUME ["/var/www", "/etc/php5/fpm/pool.d"]

# Expose ports.
EXPOSE 9000

# Define default command.
CMD ["/usr/sbin/php5-fpm", "-F"]
