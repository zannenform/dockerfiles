# データボリュームコンテナ 用 Dockerfile

データボリュームコンテナ用 Dockerfile です。  
boot2docker での利用を想定しています。  
MySQL 用データディレクトリとして、`/var/lib/mysql`ディレクトリが用意されています。

## 起動

-v オプションをつけて MySQL データディレクトリをマウント可能にします。

    docker run -itd -v /var/lib/mysql zannenform/data-volume
