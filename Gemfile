source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
# gem "rack-cors"

# Simple, efficient background processing for Ruby
gem "sidekiq"

# Useful, common monads in idiomatic Ruby
gem "dry-monads"

# A simple, configurable object container implemented in Ruby
gem "dry-container"

# Container-agnostic constructor injection mixin
gem "dry-auto_inject"

# Validation library with type-safe schemas and rules
gem "dry-validation"

gem "dry-struct"

# CSV Reading and Writing
gem "csv"

# A library for bulk insertion of data into your database using ActiveRecord.
gem "activerecord-import"

# https://jsonapi-rb.org/
gem "jsonapi-serializer"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # https://github.com/rubocop/rubocop-rspec
  gem "rubocop-rspec", require: false

  # https://github.com/rubocop/rubocop-performance
  gem "rubocop-performance", require: false

  # https://github.com/bkeepers/dotenv
  gem "dotenv"

  # help to kill N+1 queries and unused eager loading
  gem "bullet"
end

group :development do
  # https://github.com/evilmartians/lefthook
  gem "lefthook", require: false
end

group :test do
  # https://github.com/rspec/rspec-rails
  gem "rspec-rails", "~> 8.0.0"

  # https://github.com/thoughtbot/factory_bot_rails
  gem "factory_bot_rails"

  # https://github.com/DatabaseCleaner/database_cleaner-active_record
  gem "database_cleaner-active_record"

  # https://github.com/thoughtbot/shoulda-matchers
  gem "shoulda-matchers"

  # https://github.com/simplecov-ruby/simplecov
  gem "simplecov", require: false

  # https://github.com/faker-ruby/faker
  gem "faker"
end
