FROM ruby:2.6.6
RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs
WORKDIR /aquarist
COPY Gemfile Gemfile.lock /aquarist/
RUN bundle install