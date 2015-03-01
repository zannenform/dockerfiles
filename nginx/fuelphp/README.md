# nginx + fuelPHP 用 Dockerfile

nginx 用 Dockerfile です。  
fuelPHP のための config 設定を行っています。  
シングルホスト環境で利用可能で、同一ホスト内に php5-fpm コンテナが起動している必要があります。  
コンテナ間の連携のため、lua-nginx-module を利用しています。

## 起動

php5-fpmコンテナを`-link`オプションで指定します。

    docker run -itd -p 80:80 -p 443:443 --link [php5-fpmコンテナ]:php5-fpm nginx
