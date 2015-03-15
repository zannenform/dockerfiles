#!/usr/bin/env bash

PASS="P@ssw0rd"
if [ $# -eq 1 ]; then
  PASS=$1
fi

echo "#1 Install MySQL:"
echo mysql-server mysql-server/root_password password $PASS | debconf-set-selections
echo mysql-server mysql-server/root_password_again password $PASS | debconf-set-selections
apt-get install -y mysql-server
apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

echo "#2 Edit my.cnf:"
sed -i -e "s/key_buffer\([^_]\)/key_buffer_size\1/" /etc/mysql/my.cnf
sed -i -e "s/myisam-recover\([^\-]\)/myisam-recover-options\1/" /etc/mysql/my.cnf
sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "skip-host-cache" >> /etc/mysql/my.cnf
echo "skip-name-resolve" >> /etc/mysql/my.cnf

echo "#3 Start MySQL:"
/usr/bin/mysqld_safe

echo "#4 End:"
