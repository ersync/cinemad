source "https://rubygems.org"
ruby "3.2.2"

# Core Rails gems
gem "rails", "~> 7.1.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Frontend and assets
gem "vite_rails", "~> 3.0"
gem "image_processing", "~> 1.2"

# Authentication and authorization
gem "devise", "~> 4.9"
gem "omniauth", "~> 2.1"
gem "omniauth-google-oauth2", "~> 1.1"
gem "omniauth-rails_csrf_protection", "~> 1.0"

# Development utilities
gem "pry-rails", "~> 0.3.9"
gem "dotenv-rails"

# URL and data handling
gem "friendly_id", "~> 5.5", ">= 5.5.1"
gem "kaminari"

# Console and terminal utilities
gem "color"
gem "ruby-progressbar"
gem "tty-spinner"
gem "pastel"
gem "tty-progressbar"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "rspec-rails", "~> 6.1.0"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "spring"
  gem "rails-erd"
end

group :test do
  gem "shoulda-matchers"
end