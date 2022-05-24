#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

echo "Checkup dependencies..."
bundle install

echo "Initializing database..."
RAILS_ENV=production bundle exec rails db:prod

echo "Initializing cron whenever tasks..."
cron && bundle exec whenever --set 'environment=production' --update-crontab

#echo "Cleaning tmp folder..."
#rm tmp/* -Rf

echo "Creating tmp folder to add PIDs..."
mkdir -p tmp/pids

# enable docker cache
rails dev:cache

echo "Starting server..."
#RAILS_ENV=production bundle exec rails s -b 'ssl://0.0.0.0:3000?key=config/ssl/server.key&cert=config/ssl/server.crt'
#RAILS_ENV=production bundle exec rails s
bundle exec puma