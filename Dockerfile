FROM ubuntu:20.04
#SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

# see dockerfile best practice
# https://docs.docker.jp/engine/articles/dockerfile_best-practice.html
RUN apt-get update && apt-get install -y \
    autoconf \
    bison \
    build-essential \
    libssl-dev \
    libyaml-dev \
    libreadline6-dev \
    zlib1g-dev \
    libncurses5-dev \
    libffi-dev \
    libgdbm6 \
    libgdbm-dev \
    libdb-dev \
    git \
    vim \
    tzdata \
    language-pack-ja \
    curl \
  && rm -rf /var/lib/apt/lists/*

# Shift timezone to Asia/Tokyo.
ENV TZ Asia/Tokyo

# Set local to jp.
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8

# ruby install
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc

RUN mkdir -p ~/.rbenv/plugins && \
    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN ~/.rbenv/bin/rbenv install 2.6.6 && \
    ~/.rbenv/bin/rbenv global 2.6.6 && \
    ~/.rbenv/bin/rbenv exec gem install bundler
