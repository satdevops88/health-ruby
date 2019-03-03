source 'https://rubygems.org'
ruby '2.5.3'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails'
gem 'puma'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'devise'
gem 'dotenv-rails'
gem 'friendly_id'
gem 'httparty'
gem 'oj'
gem 'olive_branch'
gem "paranoia"
gem 'pg'
gem 'react-rails'
gem 'recursive-open-struct'
gem 'rollbar'
gem 'slim'
gem 'vacuum'

group :production do
	gem "skylight"
end

group :development, :test do
  gem 'byebug'
  gem 'pry'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'mini_racer', platforms: :ruby
