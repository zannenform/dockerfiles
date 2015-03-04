#!/usr/bin/env bash

PASS="P@ssw0rd"
if [ $# -ne 1 ]; then
  PASS=$1
fi


echo "#1 Install MySQL:"
DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
apt-get clean

echo "#2 Edit my.cnf:"
sed -i -e "s/key_buffer\([^_]\)/key_buffer_size\1/" /etc/mysql/my.cnf
sed -i -e "s/myisam-recover\([^\-]\)/myisam-recover-options\1/" /etc/mysql/my.cnf
sed -i -e "s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
echo "[mysqld]" >> /etc/mysql/my.cnf
echo "skip-host-cache" >> /etc/mysql/my.cnf
echo "skip-name-resolve" >> /etc/mysql/my.cnf

echo "#3 Start MySQL:"
/usr/bin/mysqld_safe &

until $(mysqladmin ping > /dev/null 2>&1)
do
	sleep 3
    echo ">"
done

echo "#4 MySQL config:"
mysqladmin -u root password $PASS
mysql -u root -p$PASS <<EOF
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '$PASS' WITH GRANT OPTION;
EOF

echo "#5 Restarting mysql:"
mysqladmin -p$PASS shutdown
/usr/bin/mysqld_safe

echo "#6 End:"
