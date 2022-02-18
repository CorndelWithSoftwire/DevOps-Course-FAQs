FROM ubuntu as custom

RUN apt-get update && apt-get install ruby-full build-essential -y
RUN gem install jekyll bundler
WORKDIR /srv/jekyll
COPY Gemfile Gemfile.lock ./
RUN bundle install
ENTRYPOINT ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]