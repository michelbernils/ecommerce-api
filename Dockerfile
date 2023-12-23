FROM ruby:3.1.2

WORKDIR /app

COPY . /app

RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]