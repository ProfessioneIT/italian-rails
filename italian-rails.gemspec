$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "italian-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "italian-rails"
  s.version     = ItalianRails::VERSION
  s.authors     = ["Marco Cosentino"]
  s.email       = ["marco.cosentino@professioneit.com"]
  s.homepage    = "https://github.com/ProfessioneIT/italian-rails"
  s.summary     = "Develop italian users based applications"
  s.description = "This rails plugin provides helpers to develop applications based on italian users."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "coffee-rails"
  s.add_dependency "sqlite3"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-rails"
end
