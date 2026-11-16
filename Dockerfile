# 開発用。本番用は Dockerfile.prod
FROM ruby:4.0.9-bookworm

RUN apt-get update && apt-get install -y postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR /mitsuami

COPY Gemfile Gemfile.lock ./
RUN bundle config set --global frozen 1 && bundle install

ENV PATH="/usr/local/bundle/bin:${PATH}"
