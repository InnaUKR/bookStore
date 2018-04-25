source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3.7'
gem 'sass-rails', '>= 3.2'
gem 'jquery-rails'
gem 'rails', '~> 5.1.4'
gem 'rake', '< 11.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'draper', '~> 3.0', '>= 3.0.1'

gem 'coffee-rails', '~> 4.2'
gem 'haml-rails'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.3'
gem 'simple_form'

gem 'rails-i18n', '~> 5.1'
gem 'devise'
# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'
gem 'figaro'
gem 'omniauth-facebook'
# gem 'capistrano-rails', group: :development
gem 'rails_admin', '~> 1.3'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'thin'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara', '~> 2.13'
  gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'database_cleaner', '~> 1.5'
  gem 'faker', '~> 1.6', '>= 1.6.6'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
