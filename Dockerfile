 
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y build-essential

COPY . /application

WORKDIR /application

RUN bundle install --deployment --without development test

ENV RAILS_ENV production

ENTRYPOINT ./entrypoint.sh