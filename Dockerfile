# Dockerfile auth microservice
FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install nodejs postgresql-client -y

RUN mkdir /application
WORKDIR /application
COPY Gemfile /application/Gemfile
COPY Gemfile.lock /application/Gemfile.lock
RUN bundle install
RUN export RAILS_ENV=production

COPY . /application

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b" "0.0.0.0"]

