ruby '2.7.2'
#ruby=2.7.2@qake

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Load .env
gem 'dotenv', '~> 2.7', '>= 2.7.6'

# Faster & easier HTML
gem 'slim-rails', '~> 3.5', '>= 3.5.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Color to the prints on console (PUTS)
gem 'colorize', '~> 0.8.1'

# soft-delete
gem 'paranoia', '~> 2.2'

# smtp mailer
gem 'net-smtp'

# terminal progress bar
gem 'progress_bar', '~> 1.3', '>= 1.3.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # RSPec Plugin for testing Views
  gem 'capybara', '~> 3.37.1'
  # RSPec Plugin for code-coverage
  gem 'simplecov', '~> 0.21.2'
  # DB management gem
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'

  # Run against the latest stable release
  gem 'rspec-rails', '~> 5.1.2'

  # Shoulda matchers helpers
  gem 'shoulda-matchers', '~> 5.1'
  
  # RuboCop Git CI
  gem 'rubocop-gitlab-security', '~> 0.1.1'
  gem 'rubocop-github', '~> 0.17.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
