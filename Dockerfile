FROM ruby:3.2

WORKDIR /app

COPY Gemfile ./

RUN touch Gemfile.lock

RUN bundle install

COPY . .

CMD ["bundle", "exec", "rspec"]