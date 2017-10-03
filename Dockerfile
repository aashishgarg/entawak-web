FROM ubuntu:16.10
MAINTAINER Sonu Kumar <sonu@headerlabs.com>
# Ignore APT warnings about not having a TTY
ENV DEBIAN_FRONTEND noninteractive
# Ensure UTF-8 locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN dpkg-reconfigure locales
# Set the Ruby version of your preference
ENV RUBY_VERSION 2.4.2
# Install build dependencies
RUN apt-get update -qq && \
    apt-get install -y -qq \
      build-essential \
      ca-certificates \
      curl \
      git \
      libcurl4-openssl-dev \
      libffi-dev \
      libgdbm-dev \
      libpq-dev \
      libreadline6-dev \
      libssl-dev \
      libtool \
      libxml2-dev \
      libxslt-dev \
      libyaml-dev \
      software-properties-common \
      wget \
      zlib1g-dev \
      mysql-client \
      libmysqlclient-dev \
      libsqlite3-dev \
      imagemagick \
      libmagickwand-dev \
      nodejs \
      zip
# Install ruby via ruby-build
RUN echo 'gem: --no-document --no-ri' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src && git clone https://github.com/sstephenson/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build $RUBY_VERSION /usr/local
# Install bundler currently  we're using this but we should not.
RUN gem install bundler
ENV APPLICATION_NAME=entawak_web
# Clean up APT and temporary files when done
RUN apt-get clean -qq && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir -p /$APPLICATION_NAME
WORKDIR /$APPLICATION_NAME
ADD Gemfile /$APPLICATION_NAME/Gemfile
ADD Gemfile.lock /$APPLICATION_NAME/Gemfile.lock
RUN bundle install
RUN useradd -u 1000 --create-home --home-dir /$APPLICATION_NAME --shell /bin/bash sonu
ADD . /$APPLICATION_NAME