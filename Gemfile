# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3.7'
gem 'pg', '~> 1.2.3'
gem 'puma', '~> 5.3.2'
gem 'sass-rails', '~> 6.0.0'
gem 'uglifier', '~> 4.2.0'
gem 'webpacker', '~> 5.4.0'
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
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'json_spec'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'travis'
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
  gem 'database_cleaner'
end
