$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'zf_user_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'zf_user_manager'
  s.version     = ZfUserManager::VERSION
  s.authors     = %w(jacopo-beschi-intersail asalomoni)
  s.email       = %w(jacopo.beschi@intersail.it andrea.salomoni@intersail.it)
  s.homepage    = 'http://www.intesail.it'
  s.summary     = 'Summary of ZfUserManager.'
  s.description = 'Description of ZfUserManager.'
  s.license     = 'PROPRIETARY'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '~> 4.1'

  # Database connector
  s.add_dependency 'pg'
  s.add_dependency 'intersail_auth'
  s.add_dependency 'zf_client'

  # Gui
  # Use SCSS for stylesheets
  s.add_dependency 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  s.add_dependency 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  s.add_dependency 'coffee-rails', '~> 4.1.0'
  # Use Jquery
  s.add_dependency 'jquery-rails'
  # Use JqueryUi as the JavaScript library
  s.add_dependency 'jquery-ui-rails'
  # UnderscoreJs lib
  s.add_dependency 'underscore-rails'
  # Twitter bootstrap with sass
  s.add_dependency 'bootstrap-sass'
  # For better user experience: be aware of document.ready issue!
  s.add_dependency 'turbolinks'

  ###############
  #  Testing
  ###############

  # Rspec
  s.add_development_dependency 'rspec-rails'
  # Automated tests with guard
  s.add_development_dependency 'guard-rspec'
  # Auto Clean DB
  s.add_development_dependency 'database_cleaner'
  # More Rspec matches
  s.add_development_dependency 'shoulda-matchers'
  # Automated Object building
  s.add_development_dependency 'factory_girl_rails'
  # Build fake data
  s.add_development_dependency 'faker'
  # Acceptance test suite
  s.add_development_dependency 'capybara'
  # Web drivers
  s.add_development_dependency 'selenium'
  s.add_development_dependency 'selenium-webdriver'
  # Allow to proxy external browser requests
  # s.add_development_dependency 'puffing-billy'
  # Allow to proxy external requests
  #s.add_development_dependency 'webmock'
  # Automatically open screenshoot
  s.add_development_dependency 'launchy'

  ################
  #  Development
  ################

  # Sqlite
  s.add_development_dependency 'sqlite3'
  # For debugging
  s.add_development_dependency 'byebug'
end
