# Data Volume Container for boot2docker

FROM ubuntu:14.04
MAINTAINER zanenform

# Ubuntu update
RUN apt-get -y update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# ユーザー作成
RUN groupadd -g 1000 storage && useradd -u 1000 -g storage storage

# MySQL データ保存ディレクトリ
RUN mkdir /var/lib/mysql && \
    chown storage:storage /var/lib/mysql


CMD ["/bin/sh"]
