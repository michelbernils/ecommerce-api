# frozen_string_literal: true

source 'https://rubygems.org'
gem 'dotenv-rails', groups: [:development, :test]

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Full-featured and flexible authentication solution
gem 'devise', '~> 4.8'

gem 'pg'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'
gem 'rexml', '~> 3.2', '>= 3.2.4'

gem 'uuid', '~> 2.3', '>= 2.3.8'

# Sidequik and Redis
gem 'redis'
gem 'sidekiq'

gem 'byebug'

# AWS SDK gem
gem 'aws-sdk-core', '~> 3.180', '>= 3.180.1'
gem 'aws-sdk-s3', '~> 1.132'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem 'jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"
#

gem 'rails-controller-testing'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  # Run against this stable release
  gem 'rspec-rails', '~> 6.0.0'
  # pretty print Ruby objects to visualize their structure. Supports custom object formatting via plugins
  gem 'awesome_print', '~> 1.8'
  gem 'byebug'
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
  gem 'byebug'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
