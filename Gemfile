source 'https://rubygems.org'


ruby '2.2.2'

gem 'redis', '~>3.2'

gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'faker'
gem 'betterlorem'
# gem 'searchkick', '~> 1.3'
gem 'autoprefixer-rails'

gem 'kaminari'

gem 'erd'
# Likes / Mention
gem 'socialization'

# Likes / Unlikes
gem 'acts_as_votable', '~> 0.10.0'

# Used for location
gem 'geocoder'
# Use unicorn as the app server
gem 'unicorn'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0'

# Use sqlite3 as the database for Active Record
gem 'pg'

gem 'bootstrap-sass'
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'
gem 'coffee-script-source'
gem 'therubyracer'
gem 'execjs'

# Haml is a templating engine for HTML
gem 'haml'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5.0.0'
gem 'turbolinks', '~> 5.0.1'
gem 'turbolinks-source', '~> 5.0'
gem 'jquery-turbolinks'

gem 'jquery-atwho-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# The administration framework for Ruby on Rails.
gem 'inherited_resources', github: 'josevalim/inherited_resources'
gem 'responders'
gem 'activeadmin', github: 'activeadmin'

# Flexible authentication solution for Rails with Warden
gem 'devise'

# Raven is a Ruby client for Sentry
gem "sentry-raven", git: "https://github.com/getsentry/raven-ruby.git"

# Authorization
gem 'cancancan'

# The Ruby cloud services library.
gem 'fog'

#Amazon s3 gem
gem 'aws-sdk'

# Manipulate images with minimal use of memory via ImageMagick / GraphicsMagick
gem 'mini_magick'

# Upload files in your Ruby applications, map them to a range of ORMs, store them on different backends.
gem "carrierwave"

# Makes http fun! Also, makes consuming restful web services dead easy.
gem 'httparty'

# Facebook OAuth2 Strategy for OmniAuth
gem 'omniauth-facebook'

# OmniAuth strategy for Twitter
gem 'omniauth-twitter'

# OmniAuth strategy for Instagram
gem 'omniauth-instagram'

# Static asset serving
gem 'rack-cors', require: 'rack/cors'
gem 'font_assets'

# Start processes using the Procfile
gem 'foreman'

# the font-awesome font for the rails asset pipeline
gem 'font-awesome-rails'

# formtastic and simpleform
gem 'simple_form'

gem 'jasny_bootstrap_extension_rails'

gem 'client_side_validations'

gem "jquery-fileupload-rails"

# Gem that allows us to brodcast to multiple channels (for ActionCable)
gem 'multicable'

# skit_gems = ['sessions_facebook', 'sessions']

skit_gems = ['sessions_instagram', 'sessions_twitter', 'sessions_facebook', 'sessions']

# if ENV["starter_kit_development"].nil?
#   skit_gems.each do |sk|
#     gem "tol_skit_#{sk}", path: "../skit-modules/tol_skit_#{sk}"
#   end
# else
  skit_gems.each do |sk|
    gem "tol_skit_#{sk}"
  end
# end

# Gems for development and test tools
group :development, :test do
  # An IRB alternative and runtime developer console
  gem 'pry'

  # A collection of tools used for Rails development
  gem 'tol'

  # When mail is sent from your application, Letter Opener will open a preview in the browser instead of sending.
  gem "letter_opener"

  # RSpec for Rails
  gem "rspec-rails"

  # Capybara is an integration testing tool for rack based web applications. It simulates how a user would interact with a website
  gem "capybara"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  # Used to check SQL querys on a page
  gem 'rack-mini-profiler'
end

  gem 'puma'

group :test do
  # Factory Girls creates factories in order to prevent entering unnecessary
  # data when creating models in test mode.
  gem "factory_girl_rails"
end
