source 'https://rubygems.org'

gem 'rails', '3.2.8'

# APPLICATION
gem 'pg'
gem 'newrelic_rpm'
gem 'hoptoad_notifier'
gem 'rails-translate-routes'
gem 'http_accept_language'
gem 'decent_exposure'
gem 'cancan'
gem 'routing_concerns'
gem 'strong_parameters'

# MODELS
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'friendly_id'
gem 'paper_trail'
gem 'acts_as_list'

# VIEWS
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass', '~> 2.1.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'simple_form'
gem 'redcarpet' 
gem 'wax_museum', git: 'git://github.com/recortable/wax_museum.git'
gem 'cache_digests'

group :production do
  gem 'unicorn'
end

group :development do 
  gem 'capistrano'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'thin'
  gem 'cane'
end

group :test do
  gem 'minitest'
  gem 'capybara'
  gem 'turn'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
end
