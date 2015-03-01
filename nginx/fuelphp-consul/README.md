# nginx + consul-template + fuelPHP 用 Dockerfile

nginx 用 Dockerfile です。  
fuelPHP のための config 設定を行っています。  
マルチホスト環境で利用するために、Consul との連携を行います。  
そのため、利用には Consul サーバーが必須となります。

## 起動

同一ホスト内のConsulをDNSサーバとして利用します。

    docker run -itd -p 80:80 -p 443:443 --dns `docker inspect --format="{{ .NetworkSettings.IPAddress }}" [Consulのコンテナ名]` nginx


## 利用環境

* Consul（サービスディスカバリーサービス）
* registrator（コンテナ自動登録サービス）
* php5-fpm（アプリケーションサーバー）
* nginx（ウェブサーバー。本dockerfile で作成されるコンテナ）

というコンテナ構成を想定しています。  

### Consul

サービスディスカバリーサービスです。  
利用方法は公式ページにて確認してください。  
dockerイメージ`progrium/docker-consul`を利用すると簡単に Consul の環境が整います。  
```
docker pull progrium/consul
```

#### シングルホストで試用してみる場合

```
docker run -d -p 8300:8300 -p 8301:8301/tcp -p 8301:8301/udp -p 8302:8302/tcp -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 8600:53/tcp -p 8600:53/udp --name consulserver --hostname consul1 progrium/consul -server -advertise ホストマシン.の.IP.アドレス -bootstrap
```

#### マルチホストで利用する場合

４台以上のマルチホスト環境で、Consulクラスタノードを３台稼働させる場合は、以下のように Consul を起動します。  
* 1台目  
```
docker run -d -p 8300:8300 -p 8301:8301/tcp -p 8301:8301/udp -p 8302:8302/tcp -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 8600:53/tcp -p 8600:53/udp --name consulserver --hostname consul1 progrium/consul -server -bootstrap-expect 3
```  
2台目のノードからは、1台目のノードに接続するので、1台目のノードのIPアドレスを確認しておきます。  
```
docker inspect -f '{{.NetworkSettings.IPAddress}}' consul
```  
* 2台目  
```
docker run -d -p 8300:8300 -p 8301:8301/tcp -p 8301:8301/udp -p 8302:8302/tcp -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 8600:53/tcp -p 8600:53/udp --name consulserver --hostname consul2 progrium/consul -server -join 1台目の.ノードの.IP.アドレス
```  
* 3台目  
```
docker run -d -p 8300:8300 -p 8301:8301/tcp -p 8301:8301/udp -p 8302:8302/tcp -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 8600:53/tcp -p 8600:53/udp --name consulserver --hostname consul3 progrium/consul -server -join 1台目の.ノードの.IP.アドレス
```  
* 4台目以降  
クラスタノード以上のサーバーには、Counsul クライアントノードを起動させます。  
（-server オプションを取り除くことでクライアントノードになります）  
```
docker run -d -p 8400:8400 -p 8500:8500 -p 8600:53/udp --name consulserver --hostname consul4 progrium/consul -join 1台目の.ノードの.IP.アドレス
```  

設定後、任意のConsulコンテナから`consul members`コマンドを実行すると、現在のクラスタメンバーが確認できます。  
```
docker exec -it consulserver consul members
```

また、ウェブコンソールも利用可能です。  
```
http://Consul.コンテナ.の.IPアドレス:8500/
```


### registrator

registrator はコンテナの情報を Consul に自動登録するサービスです。  
マルチホスト環境の場合、全てのホストでサービスを起動させます。  
`progrium/registrator`でdockerイメージが提供されているので、こちらを利用します。  
```
docker pull progrium/registrator
```

起動させる場合、ホストサーバーのdockerソケットを共有する必要があります。  
```
docker run -d -v /var/run/docker.sock:/tmp/docker.sock --name registrator -h registrator1 progrium/registrator consul://localhost:8500
```

### php5-fpm

本dockerfile では php5-fpm を稼働させているアプリケーションサーバーコンテナが必要です。  
コンテナ名は`php5-fpm`を想定しています。

```
docker pull zannenform/php5-fpm
docker run -itd -p 9000:9000 -v [/pool.d-dir/path]:/etc/php5/fpm/pool.d -v [/html-dir/path]:/var/www php5-fpm
```
