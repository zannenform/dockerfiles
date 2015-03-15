# php5-fpm
#
# php config: Asia/Tokyo
# 
# docker run -itd -p 9000:9000 -v <pool.d-dir>:/etc/php5/fpm/pool.d -v <html-dir>:/var/www --link [mysqlコンテナ]:mysql zannenform/php5-fpm

FROM ubuntu:14.04
MAINTAINER zanenform

# Install PHP-FPM.
RUN apt-get -y update && apt-get upgrade -y && \
    apt-get install -y php5-fpm php5-cli php5-json php5-mysql libmysqlclient-dev mysql-common && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Set up PHP.
RUN echo "cgi.fix_pathinfo=0" > /etc/php5/fpm/conf.d/local.ini && \
  echo "date.timezone = Asia/Tokyo" >> /etc/php5/fpm/conf.d/local.ini && \
  sed -i -e "s/^listen =.*$/listen = 9000/" /etc/php5/fpm/pool.d/www.conf && \
  sed -i -e "s/^user =.*$/user = 1000/" /etc/php5/fpm/pool.d/www.conf && \
  mkdir /var/www

# Define mountable directories.
VOLUME ["/var/www", "/etc/php5/fpm/pool.d"]

# Expose ports.
EXPOSE 9000

# Define default command.
CMD ["/usr/sbin/php5-fpm", "-F"]
