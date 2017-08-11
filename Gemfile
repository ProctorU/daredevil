source 'https://rubygems.org'

# Declare your gem's dependencies in daredevil.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

gem 'minitest-ci'   # for CircleCI

group :development do
  gem 'pry'
end

group :test do
  gem 'mocha'
  gem 'minitest-reporters'
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'minitest-focus'
  gem 'pry-byebug', group: %i[development test]
  gem 'pry-highlight', group: %i[development test]
  gem 'pry-rails', group: %i[development test]
  gem 'warden'
end
