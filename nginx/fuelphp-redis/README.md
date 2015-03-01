# nginx + redis + fuelPHP 用 Dockerfile

nginx 用 Dockerfile です。  
fuelPHP のための config 設定を行っています。  
マルチホスト環境で利用するために、redis との連携を行います。  
そのため、利用には redis サーバーが必須となります。

## 起動

redis サーバーのIPアドレスをを`--env REDISSERVER=`オプションで指定します。

    docker run -itd -p 80:80 -p 443:443 --env REDISSERVER=[redis.の.IP.アドレス] nginx

## redis に登録するデータ

起動しているphp5-fpmコンテナのIPアドレスとポート番号をリストとして登録します。

|キー|バリュー|
|---|---|
|upstream|php5-fpmコンテナ1のIPアドレス:ポート番号|
|upstream|php5-fpmコンテナ2のIPアドレス:ポート番号|

    redis> rpush upstream php5-fpm.コンテナの.IP.アドレス:9000

サービスディスカバリーは用意していません。
