FROM ruby:3.2.2

RUN apt-get update -qq && apt-get install -y \postgresql-client

RUN gem install bundler -v 2.2.11

RUN apt-get install -y git

WORKDIR /rails_app

COPY Gemfile Gemfile.lock /rails_app/
RUN bundle install

COPY . /rails_app

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]