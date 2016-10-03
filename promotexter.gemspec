$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "promotexter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "promotexter"
  s.version     = Promotexter::VERSION
  s.authors     = ["denmarkmeralpis"]
  s.email       = ["denmark@nueca.net"]
  s.homepage    = "http://genmcrg.com"
  s.summary     = "Simple way of sending SMS via Promotexter API"
  s.description = "The gem provides a simple way of sending SMS via Promotexter API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.require_paths = ['lib']

  # s.add_dependency "rails", "=> 4.0.0"

  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 10.0"
end
