# php5-fpm 用 Dockerfile

php5-fpm 用 Dockerfile です。  
boot2docker での利用を想定しています。  
既定では外部サーバーからのアクセスを無制限に許可することで、マルチホストに対応しています。

## 起動

ドキュメントルートを`-v`オプションで指定します。

    docker run -itd -p 9000:9000 -v [/html-dir/path]:/var/www zannenform/php5-fpm

## アプリケーションプールを指定した起動

アプリケーションプールのディレクトリをマウントすることで、任意のプール設定で起動することができます。

    docker run -itd -p 9000:9000 -v [/pool.d-dir/path]:/etc/php5/fpm/pool.d -v [/html-dir/path]:/var/www zannenform/php5-fpm

## MySQL コンテナを指定した起動

MySQLコンテナを`--link`で指定することで、php cli の実行でMySQLにアクセスすることが可能です。

    docker run -itd -p 9000:9000 -link [mysqlコンテナ]:mysql -v [/html-dir/path]:/var/www zannenform/php5-fpm


## php.ini

|項目|値|
|---|---|
|date.timezone|Asia/Tokyo|

その他はデフォルト設定です。
