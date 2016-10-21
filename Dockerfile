FROM ruby:2-alpine
MAINTAINER Victor Bersy <victorbersy@gmail.com>

RUN apk add --update \
  build-base \
  libxml2-dev \
  libxslt-dev \
  postgresql-dev \
  && rm -rf /var/cache/apk/*

RUN mkdir /usr/app
RUN mkdir /usr/app/logs
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
COPY config/database.yml.example /usr/app/config/database.yml

RUN bundle install

COPY . /usr/app

CMD ["./bin/eve_online_killboard_to_slack"]
