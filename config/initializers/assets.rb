# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.

Rails.application.config.assets.version = '1.0'
# Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
# Rails.application.config.assets.precompile += %w( iconic_fill.otf )
# Rails.application.config.assets.precompile += %w( iconic_fill.eot )
# Rails.application.config.assets.precompile += %w( iconic_fill.woff )
# Rails.application.config.assets.precompile += %w( iconic_fill.ttf )
# Rails.application.config.assets.precompile += %w( iconic_fill.svg )
# Rails.application.config.assets.precompile += %w( iconic_stroke.otf )
# Rails.application.config.assets.precompile += %w( iconic_stroke.eot )
# Rails.application.config.assets.precompile += %w( iconic_stroke.woff )
# Rails.application.config.assets.precompile += %w( iconic_stroke.ttf )
# Rails.application.config.assets.precompile += %w( iconic_stroke.svg )
Rails.application.config.assets.precompile += %w( theme_js/* )
Rails.application.config.assets.precompile += %w( theme_script.js )
Rails.application.config.assets.precompile += %w( rails.validations.js )
Rails.application.config.assets.precompile += %W( audios/* )
Rails.application.config.assets.precompile += %w( cable.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
