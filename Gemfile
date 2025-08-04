source "https://rubygems.org"
ruby "3.4.2"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

gem "devise"
gem "stripe"
gem "stripe_event"
gem "chronic"
gem "kaminari"
gem "rails-erd"
gem "bullet"
gem "annotate"
gem "boot"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem 'avo', '~> 3.0'
gem 'image_processing', '~> 1.2' # Pics Active Storage
group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "pry-rails"
  gem "pry-byebug"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem 'dotenv-rails', groups: [ :development, :test ]
  gem "table_print"
end

group :development do
  gem "web-console"
  gem "letter_opener"
  gem "letter_opener_web"
  gem "localhost"
  gem "rubocop-rails"
  gem "rubocop-performance"
  gem "better_errors"
  gem "binding_of_caller"
  gem "listen"
  gem "spring"
  gem "spring-watcher-listen"
  gem "rerun"
  gem "guard"
  gem "guard-rails"
  gem "guard-livereload"
  gem "rack-livereload"
  gem "colorize"
  gem "rainbow"
  gem "tty-spinner"
  gem "tty-progressbar"
  gem "awesome_print"
  gem "hirb"
  gem "rails_panel"
  gem "meta_request"
  gem "rails_semantic_logger"
  gem "amazing_print"
  gem "rails_stdout_logging"
  gem "lograge"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "simplecov", require: false
  gem "shoulda-matchers"
  gem "database_cleaner-active_record"
  gem "webmock"
  gem "vcr"
end

group :production do
  gem "pg", "~> 1.6"
  gem "rails_12factor"
end
