# Redis Server

FROM ubuntu:14.04
MAINTAINER zanenform

# Install Redis
RUN apt-get -y update && apt-get install -y redis-server

# Expose ports.
EXPOSE      6379

# Define default command.
ENTRYPOINT  ["/usr/bin/redis-server"]
