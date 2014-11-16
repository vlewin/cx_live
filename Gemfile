source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.1.6'
gem 'sqlite3'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'thin'
gem 'roo'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_20]
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rails_layout'
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
end

group :test do
  gem 'rspec-rails' #, '~> 3.1.2'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers', require: false
  gem 'launchy'
end

group :production do
  gem 'rails_12factor'
  gem 'pg'
end
