# frozen_string_literal: true

source 'https://rubygems.org'

# main app dependencies
ruby File.read('.ruby-version').strip

gem 'hanami',       '~> 1.3'
gem 'activerecord'
gem 'active_record_migrations'
gem 'rake'

# database orm
gem 'pg'

# serialize
gem 'jsonapi-hanami', github: 'jsonapi-rb/jsonapi-hanami'

# code styling
gem 'rubocop-rails'

group :development do
  gem 'hanami-webconsole'
  gem 'pry'
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'capybara'
  gem 'rspec'
end
