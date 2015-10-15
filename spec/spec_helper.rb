# Require support files
require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
require 'byebug'
require 'rspec/rails'
require 'spec_helper'
require 'database_cleaner'
require 'intersail_auth/test_helpers'

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

# Setup migration paths
ActiveRecord::Migrator.migrations_paths = [File.expand_path("../test/dummy/db/migrate", __FILE__)]
ActiveRecord::Migrator.migrations_paths << File.expand_path('../db/migrate', __FILE__)

####
# Capybara
####
require 'capybara/rails'
require 'capybara/rspec'
# require 'billy/rspec'
# require 'webmock/rspec'
Capybara.app = ZfUserManager::Engine
Capybara.default_wait_time = 10
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end
Capybara.javascript_driver = :selenium
Capybara.app_host = 'http://localhost:3000'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.color = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.include Helpers
  config.include ZfUserManager::Engine.routes.url_helpers
  config.include IntersailAuth::TestHelpers::Cookies

  # Database handling
  # migrate test schema if needed
  ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
  # Clean database at start of the suite and then
  # just uses transactions
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |single_test|
    DatabaseCleaner.cleaning do
      single_test.run
    end
  end

  # clear all remaning test data
  # config.after(:all) do
  #   Helpers::File.clear_test_data
  # end
end