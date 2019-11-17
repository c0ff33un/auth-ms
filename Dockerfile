FROM ruby:2.6.5-alpine3.10

RUN apk add --update build-base postgresql-dev tzdata \
  && rm -rf /var/cache/apk/*


RUN gem install bundler
ENV RAILS_ENV production

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install --without development test

COPY . /myapp


CMD /bin/sh -c "rm -f /myapp/tmp/pids/server.pid && ./bin/rails server --log-to-stdout"