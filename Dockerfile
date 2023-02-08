FROM ruby:2.7-alpine
RUN apk update && apk add alpine-sdk
RUN gem update --system
RUN gem install jekyll bundler
WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install
ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]