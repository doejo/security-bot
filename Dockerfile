FROM ruby:2.3
MAINTAINER dan@doejo.com

ADD . /app
WORKDIR /app
RUN bundle install

CMD ["bundle", "exec", "rake", "run"]