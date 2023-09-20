FROM ubuntu:trusty
MAINTAINER Arkadiusz Neumann

ENV DEBIAN_FRONTEND noninteractive
ENV NAME Darwin

ARG http_proxy http://example-proxy.corp.com

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN echo $'#!/bin/sh\nexit 101' > /usr/sbin/policy-rc.d
EXPOSE 8811
RUN chmod +x /usr/sbin/policy-rc.d

RUN \
  apt-get update && \
  apt-get -y install \
          software-properties-common \
          vim \
          pwgen \
          unzip \
          curl \
          git-core && \
  rm -rf /var/lib/apt/lists/*
  
  USER root

  ENTRYPOINT ["/bin/echo", "Welcome, $NAME"]
