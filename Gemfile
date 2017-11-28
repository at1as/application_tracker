source 'https://rubygems.org'


gem 'rails', '4.2.7.1'
gem 'puma'                              # Use multithreaded puma webserver

# JavaScript & CSS
gem 'autoprefixer-rails'
gem 'coffee-rails', '~> 4.0.0'          # Use CoffeeScript for .js.coffee assets and views
gem 'bootstrap-datepicker-rails'        # Datepicker for Bootstrap
gem 'bootstrap-sass', '~> 3.2.0'        # Use bootstrap with Sass
gem 'bootstrap-table-rails', '~> 1.8.1' # Table sorting
gem 'bootstrap-will_paginate', '0.0.10' # Pagination
gem 'jquery-timepicker-rails'           # Timepicker dropdowns for form fields
gem 'jquery-rails'                      # Use jQuery as JS Library 
gem 'jquery-turbolinks'                 # Support for Turbolinks with jQuery
gem 'turbolinks'                        # Selectively reload portions of pages rather than full reload
gem 'simple_calendar', '~> 2.0'         # Simple JS calendar
gem 'sass-rails', '~> 5.0'              # Use SCSS for stylesheets
gem 'uglifier', '>= 1.3.0'              # Use Uglifier as compressor for JavaScript assets
gem 'will_paginate', '3.0.7'            # Pagination

# Other
gem 'bcrypt', '~> 3.1.7'                # Use ActiveModel has_secure_password
gem 'high_voltage', '~> 2.4'            # Serve static pages without creating controller
gem 'jbuilder', '~> 2.0'                # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'paperclip', '~> 4.3'               # Upload images
gem 'sdoc', '~> 0.4.0',   group: :doc   # bundle exec rake doc:rails generates the API under doc/api.
gem 'spring',   group: :development     # Spring speeds up development by keeping app running in background


group :development, :test do
  gem 'brakeman', :require => false     # Generate security reports brakeman
  gem 'byebug'                          # Debugger
  gem 'sqlite3'                         # Use SQLite for Development & Test
  gem 'web-console', '~> 2.0'           # Access an IRB console on exception pages or by using <%= console %> in views
end

group :production do
  gem 'pg', '~>0.18.1'                  # Use postgres for production (for Heroku deploy)
  gem 'rails_12factor'                  # Necessary for Heroku
end

ruby ENV['CUSTOM_RUBY_VERSION'] || '2.2.3'

