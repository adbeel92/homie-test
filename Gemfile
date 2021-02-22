# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem 'rails', '~> 6.1.2', '>= 6.1.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~>1.1.1'

# For generating fake data such as names, addresses, and phone numbers.
gem 'faker', '~>2.16.0'

# Allows generate your JSON in an object-oriented and convention-driven manner.
gem 'active_model_serializers', '~>0.10.12'

# Pagination
gem 'api-pagination', '~> 4.6.3'
gem 'kaminari', '~> 1.1.1'

# A ruby implementation of the RFC 7519 OAuth JSON Web Token (JWT) standard.
gem 'jwt', '~> 2.2.2'

# RailsAdmin is a Rails engine that provides an easy-to-use interface for managing your data
gem 'rails_admin', '~> 2.0'

# Flexible authentication solution for Rails with Warden.
gem 'devise', '~> 4.7.3'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.1.0'
  gem 'pry-nav', '~> 0.3.0'
  gem 'pry-rails', '0.3.9'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'shoulda-matchers', '~> 4.5.1'
  gem 'simplecov', '~> 0.21.2'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop', '~> 1.10.0', require: false
  gem 'spring', '~> 2.1.1'
end
