# syntax=docker/dockerfile:1
FROM ruby:2.7.2

# replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# update the repository sources list
# and install dependencies
RUN apt-get -qq -y update && apt-get -qq -y upgrade
RUN curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | gpg --import --no-default-keyring --keyring ./nodesource.gpg

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 14.15.0
ENV SECRET_KEY_BASE 8718e1e82dd879de243d6031cd40f75305e475b091875c78cbdfc01a786cb4e3295e171e81d71a16ce0e31a3b5d5406ff85c84a483e8ccc5ca9b23af34f4326d
RUN mkdir $NVM_DIR

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# install node and npm
RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN apt-get update -qq && apt-get install -y postgresql-client
RUN apt-get install -y cron
WORKDIR /myapp
RUN npm i -g yarn

# Set env vars
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Install dependencies
COPY . /myapp
RUN yarn install
RUN gem install bundler
RUN bundle config set --local without 'development test'
RUN bundle install

# Rails precompile
RUN bundle exec rails DATABASE_URL=postgresql:does_not_exist assets:precompile --trace

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /myapp/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

#ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
#CMD ["rails", "server", "-b", "0.0.0.0"]
#RUN bundle exec whenever --update-crontab --set environment='production'
#CMD cron && bundle exec puma
