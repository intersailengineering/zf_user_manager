$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zf_user_manager/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zf_user_manager"
  s.version     = ZfUserManager::VERSION
  s.authors     = ["jacopo-beschi-intersail"]
  s.email       = ["jacopo.beschi@intersail.it"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ZfUserManager."
  s.description = "TODO: Description of ZfUserManager."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.1"

  s.add_development_dependency "sqlite3"
end
