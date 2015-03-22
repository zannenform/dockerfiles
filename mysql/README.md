# MySQL5.6 用 Dockerfile for boot2docker

boot2docker 向け MySQL サーバー用 Dockerfile です。
boot2docker ユーザーと MySQL ユーザーを同一にしています。

## 起動

    docker run -itd -p 3306:3306 zannenform/mysql

## root パスワードオプション

`docker run`コマンドにオプション`-e "ROOT_PASSWORD="`をつけると、その文字列が MySQL の root パスワードになります。
省略した場合、root パスワードには `P@ssw0rd` が設定されます。

    docker run -itd -p 3306:3306 -e "ROOT_PASSWORD=[任意のMySQLのrootパスワードを指定]" zannenform/mysql

## クライアントのディレクトリを MySQL データディレクトリにする

volume のマウント指定を行うことで、クライアントのディレクトリを MySQL データディレクトリにすることができます。

    docker run -itd -p 3306:3306 --volume /client/directory/path:/var/lib/mysql zannenform/mysql

## データボリュームコンテナに MySQL データを保存する

同じホスト内のデータボリュームコンテナをマウント指定することで、データボリュームコンテナに MySQL データディレクトリを作成することができます。

    docker run -itd -p 3306:3306 --volumes-from [データボリュームコンテナ名] zannenform/mysql

