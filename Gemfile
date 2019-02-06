# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3.7'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'rake', '< 11.0'
gem 'sass-rails', '>= 3.2'
gem 'therubyracer', platforms: :ruby
gem 'uglifier', '>= 1.3.0'

gem 'draper', '~> 3.0', '>= 3.0.1'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'coffee-rails', '~> 4.2'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'
gem 'haml-rails'
gem 'simple_form'
gem 'devise'
gem 'rails-i18n', '~> 5.1'
gem 'bcrypt', '~> 3.1.7'
gem 'figaro'
gem 'omniauth-facebook'
gem 'rails_admin', '~> 1.3'
gem 'carrierwave', '~> 1.0'
gem 'fog-google'
gem 'google-api-client', '> 0.8.5', '< 0.9'
gem 'mime-types'
gem 'aasm'
gem 'cancancan', '~> 2.0'
gem 'dotenv-rails'
gem 'rectify'
gem 'wicked'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'database_cleaner', '~> 1.5'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'rails-controller-testing'
  gem 'shoulda-matchers', '~> 3.0', require: false
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

ruby "2.4.1"