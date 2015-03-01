# データボリュームコンテナ 用 Dockerfile for boot2docker

boot2docker 向け データボリュームコンテナ用 Dockerfile です。
MySQL データディレクトリを持っています。

## 起動

-v オプションをつけて MySQL データディレクトリをマウント可能にします。

    docker run -itd -v /var/lib/mysql storage
