# nginx + fuelPHP 用 Dockerfile

nginx 用 Dockerfile です。  
fuelPHP のための config 設定を行っています。  
シングルホスト環境で利用可能で、同一ホスト内に php5-fpm コンテナが起動している必要があります。  
コンテナ間の連携のため、lua-nginx-module を利用しています。

## 起動

ドキュメントルートを`-v`オプションで指定します。
php5-fpmコンテナを`-link`オプションで指定します。

    docker run -itd -p 80:80 -p 443:443 -v [/html-dir/path]:/var/www --link [php5-fpmコンテナ]:php5-fpm zannenform/nginx-fuelphp

MySQLコンテナを`-link`オプションで指定することで、MySQLのIPアドレス、ポートを環境変数に設定することができます。
fuelPHP の場合`$_SERVER['MYSQL_PORT_3306_TCP_ADDR']`を利用して MySQL との接続を行います。
(fastCGIのバグのため、filter_input関数での取得はできない可能性があります)

    docker run -itd -p 80:80 -p 443:443 -v [/html-dir/path]:/var/www  --link [php5-fpmコンテナ]:php5-fpm --link [MySQLコンテナ]:mysql -e "FUEL_ENV=local" zannenform/nginx-fuelphp

fuelPHP の実行環境を`-e`オプションで指定することが可能です。

    docker run -itd -p 80:80 -p 443:443 -v [/html-dir/path]:/var/www  --link [php5-fpmコンテナ]:php5-fpm -e "FUEL_ENV=[local|development|production|...]" zannenform/nginx-fuelphp
