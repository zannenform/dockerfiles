# MySQL for boot2docker
#
# オプション値として root のパスワードを指定すると、そのパスワードでrootが作成されます。
# デフォルトのパスワードは P@ssw0rd です。
#
# docker run -itd -p 3306:3306 --volumes-from [データボリュームコンテナ] mysql [任意のMySQLのrootパスワードを指定]

FROM ubuntu:14.04
MAINTAINER zanenform

# Ubuntu update
RUN apt-get -y update

# mysql ユーザーを boot2docker ユーザーにする
RUN groupadd mysql && useradd --uid 1000 -g mysql mysql

# Hack for initctl not being available in Ubuntu
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# セットアップ用endpoint.shをコピー
COPY entrypoint.sh /

# Define mountable directories.
VOLUME ["/var/lib/mysql"]

# Expose ports.
EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]
