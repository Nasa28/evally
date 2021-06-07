# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3.7'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.3.2'
gem 'sass-rails', '~> 6.0.0'
gem 'uglifier', '~> 4.2.0'
gem 'webpacker'
gem 'rack-cors', '~> 1.1.1'
gem 'bootsnap', '~> 1.4.4', require: false
gem 'haml', '~> 5.2.1'
gem 'blueprinter', '~> 0.22.0'
gem 'pundit', '~> 2.1.0'
gem 'devise', '~> 4.8.0'
gem 'devise_invitable', '~> 2.0.5'
gem 'jwt', '~> 2.2.3'
gem 'faraday'
gem 'redis-namespace', '~> 1.8.1'
gem 'sidekiq', '~> 6.2.1'
gem 'kaminari', '~> 1.2.1'
gem 'pg_search', '~> 2.3.5'
gem 'whenever', '~> 1.0.0', require: false

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', '~> 4.3.1', require: false
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'cypress-on-rails', '~> 1.5'
  gem 'factory_bot_rails', '~> 4.11'
  gem 'faker', '~> 1.9.1'
  gem 'json_spec', '~> 1.1'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 3.8'
  gem 'shoulda-matchers', '~> 4.3.0'
  gem 'simplecov', '~> 0.16.1'
  gem 'rubocop', '~> 0.80.0', require: false
  gem 'rubocop-rails', require: false
  gem 'travis', '1.8.10'
  gem 'webmock'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-yarn'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner', '~> 1.8'
end
