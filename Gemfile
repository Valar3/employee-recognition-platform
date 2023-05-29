# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'

gem 'bullet'
gem 'devise'
gem 'faker'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'
gem 'pry'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'will_paginate', '~> 3.3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'
gem 'simple_form'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Debugging tool
  gem 'byebug'
  gem 'byebug-dap', '~> 0.1.4'
  gem 'factory_bot_rails'

  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rails', '2.13.2'
  gem 'rubocop-rspec', '2.8.0'
  # Tests
  gem 'capybara'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers', '~> 4.0', require: false
end
group :development do
  gem 'letter_opener'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'pundit', '~> 2.3'

gem 'rubocop', '~> 1.25'
