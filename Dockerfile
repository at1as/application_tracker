FROM alpine:3.2  

# System dependencies
RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake ruby-rdoc ruby-nokogiri \  
  ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs

ADD Gemfile /app/  
ADD Gemfile.lock /app/
ENV CUSTOM_RUBY_VERSION 2.2.2

# System dependencies needed by Ruby
RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev \  
  postgresql-dev libc-dev linux-headers \
  libxml2-dev libxslt-dev libgcrypt g++ \
  ca-certificates yaml readline ncurses gdbm libffi curl libxslt-dev && \
  gem install bundler && \
  bundle config build.nokogiri --use-system-libraries && \
  cd /app ; bundle install --without development test --path vendor/cache && \
  apk del build-dependencies

ADD . /app  
RUN chown -R nobody:nogroup /app  
USER nobody

WORKDIR /app

ENV RUBY_ENV production
CMD ["bin/rails", "server"]
