require 'colorize'

# Only rake tasks allowed to run on production
namespace :db do
  desc 'Update the DB structure & populate it'
  task prod: :environment do
    puts 'Production Env'.colorize(:blue)
    system('rails db:migrate RAILS_ENV=production')
    system('rails db:seed RAILS_ENV=production')
  end
end
