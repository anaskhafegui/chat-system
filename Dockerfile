FROM ruby:2.6.3

ENV BUNDLER_VERSION=2.0.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-server

RUN gem install mysql2 -v '0.5.2' -- --with-ldflags=-L/usr/local/opt/openssl/lib --with-cppflags=-I/usr/local/opt/openssl/include

RUN gem install bundler -v 2.0.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle config build.nokogiri --use-system-libraries

RUN bundle check || bundle install


COPY . ./

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]     