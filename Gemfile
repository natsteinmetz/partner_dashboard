source 'https://rubygems.org'

ruby "2.0.0"

gem 'rails', '3.2.13'
gem 'devise', '~> 2.2.4'
gem 'devise_invitable', '~> 1.1.0'

gem 'dynamic_form', '~> 1.1.4'

gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'font-awesome-sass-rails'

gem 'faker', '~>1.0.1'

gem 'gravatar_image_tag'

# Needs to be outside of assets because we have some dynamically
# generated coffeescript.
gem 'coffee-rails', '~> 3.2.1'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :production do
  gem 'pg'
end

group :production, :development do
  gem 'unicorn'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'shoulda-matchers', '~> 2.1.0'
  gem 'pry-rails'
  gem 'pry-debugger'
  gem 'pry-doc'
  gem 'binding_of_caller'
  gem 'dotenv-rails'
end

group :development do
  gem 'better_errors'
  gem 'meta_request'
  gem 'rails-erd' #visualize erd
end

group :test do
  gem 'capybara', '~> 2.1.0'
  gem 'capybara-webkit', '~> 1.0.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy'
  gem 'simplecov', :require => false
  gem 'factory_girl_rails', '~> 4.0'
  gem 'email_spec', '1.2.1'
end


