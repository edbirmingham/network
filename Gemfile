source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
gem 'bootsnap'
# Used to get content_tag_for back in Rails 5
gem 'record_tag_helper'
gem 'puma'
# Use Postgresql in production
gem 'pg'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-generators', '~> 3.3.4'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Cloning ActiveRecord models.
gem 'deep_cloneable', '~> 2.3.2'

# Pagination
gem 'kaminari'
# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'select2-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use datetime picker from Bootstrap
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'

# gem for in-place editing
gem 'bootstrap-editable-rails'

gem 'cancancan', '~> 2.0'

# Use Ancestry for tasks/subtasks
gem 'ancestry'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#Gem for copying to clipboard
gem 'zeroclipboard-rails'

# Network Gems
gem 'omniauth-surveymonkey'
gem 'devise', '~> 4.1'

# Until the new API calls are generally available, we must manually specify a
# fork of the Heroku API gem:
gem 'platform-api'

gem 'letsencrypt-rails-heroku', group: 'production'
gem 'reform-rails'
gem 'reform'

gem 'two_factor_authentication'
gem 'rqrcode'
gem 'ruby_http_client'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'timecop'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.5'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Listen for file updates in development mode rather than polling.
  gem 'listen'
end

gem 'rollbar'

# PgSearch builds named scopes that take advantage of PostgreSQL's full text search.
gem 'pg_search'

group :test do
  gem 'mocha'
end
