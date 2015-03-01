# Data Volume Container for boot2docker

FROM dockerfile/ubuntu:14.04
MAINTAINER zanenform

# Ubuntu update
RUN apt-get -y update

# ユーザー作成
RUN groupadd -g 1000 storage
RUN useradd -u 1000 -g storage storage

# MySQL データ保存ディレクトリ
RUN mkdir /var/lib/mysql
RUN chown storage:storage /var/lib/mysql
