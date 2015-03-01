# Data Volume Container for boot2docker

FROM ubuntu:14.04
MAINTAINER zanenform

# ユーザー作成
RUN groupadd -g 1000 storage
RUN useradd -u 1000 -g storage storage

# MySQL データ保存ディレクトリ
RUN mkdir /var/lib/mysql
RUN chown storage:storage /var/lib/mysql
