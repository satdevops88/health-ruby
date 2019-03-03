# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'bootstrap-sass', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'bootstrap-sass', 'assets', 'javascripts')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'bootstrap-sass', 'assets', 'stylesheets')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'font-awesome', 'css')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'font-awesome', 'fonts')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'jquery', 'dist', 'cdn')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'jquery-ujs', 'src')
Rails.application.config.assets.paths << Rails.application.root.join('node_modules', 'jquery-typeahead', 'dist')

Rails.application.config.assets.precompile += %w(
  admin.css
  admin.js
  webpack/app-bundle.css
  webpack/app-bundle.js
  webpack/vendor-bundle.js
)