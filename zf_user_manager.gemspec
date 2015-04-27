$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'zf_user_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'zf_user_manager'
  s.version     = ZfUserManager::VERSION
  s.authors     = %w(jacopo-beschi-intersail asalomoni)
  s.email       = %w(jacopo.beschi@intersail.it andrea.salomoni@intersail.it)
  s.homepage    = 'TODO'
  s.summary     = 'TODO: Summary of ZfUserManager.'
  s.description = 'TODO: Description of ZfUserManager.'
  s.license     = 'PROPRIETARY'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.1'

  # Databse connector
  s.add_dependency 'pg'

  # Gui
  # Use SCSS for stylesheets
  s.add_dependency 'sass-rails', '~> 5.0'
  # Use Uglifier as compressor for JavaScript assets
  s.add_dependency 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  s.add_dependency 'coffee-rails', '~> 4.1.0'
  # Twitter bootstrap with sass
  s.add_dependency 'bootstrap-sass'

  # Development
  # Rspec
  s.add_development_dependency 'rspec-rails'
  # Automated tests with guard
  s.add_development_dependency 'guard-rspec'
  # Auto Clean DB
  s.add_development_dependency 'database_cleaner'
  # More Rspec matches
  s.add_development_dependency 'shoulda-matchers'
  # Automated Object building
  s.add_development_dependency 'factory_girl_rails', '~> 4.0'
  # Build fake data
  s.add_development_dependency 'faker'
  # Sqlite
  s.add_development_dependency 'sqlite3'
end
