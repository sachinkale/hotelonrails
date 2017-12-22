FROM ruby:2.4.0

ENV PATH=/code/bin:$PATH RAILS_ENV=development RACK_ENV=development LANG=C.UTF-8

RUN mkdir /code
ADD ./Gemfile* /code/
ADD . /code

WORKDIR /code

# Run dependencies install commands
RUN bundle install
