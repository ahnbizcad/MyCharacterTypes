source 'https://rubygems.org'
ruby '1.9.3'

# Default

#ruby-gemset=railstutorial_rails_4_0

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

#gem 'rails', '4.0.1'
#gem 'sass-rails', '~> 4.0.0'
#gem 'uglifier', '>= 1.3.0'
#gem 'coffee-rails', '~> 4.0.0'
#gem 'jquery-rails'
#gem 'turbolinks'
#gem 'jbuilder', '~> 1.2'

gem 'rails', '4.0.2'
gem 'sass-rails', '4.0.1'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'

#database
gem 'pg', '0.17.1'

group :development, :test do
  ##gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  # Automated testing.
  gem 'guard-rspec', '2.5.0'
  # Speed up testing by loading test server once for reuse.
  gem 'spork-rails', '4.0.0'
  gem 'guard-spork', '1.5.0'
  gem 'childprocess', '0.3.6'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'

  gem 'rb-notifu', '0.0.4'
  gem 'win32console', '1.3.2'
  gem 'wdm', '0.1.0'
end

group :production do
  gem 'rails_12factor', '0.0.2'
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end