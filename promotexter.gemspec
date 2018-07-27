$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'promotexter/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'promotexter'
  s.version     = Promotexter::VERSION
  s.authors     = ['Nujian Den Mark Meralpis', 'Cecille Sevilla', 'Andrey Ramirez', 'Jett Robin Andres', 'Andrei Navarro']
  s.email       = ['denmarkmeralpis@gmail.com', 'cecillegsevilla01@gmail.com', 'jettrobin.andres@gmail.com', 'ramirez.jag00@gmail.com', 'andrei@phonebooky.com']
  s.homepage    = 'https://github.com/denmarkmeralpis/promotexter'
  s.summary     = 'Simple way of sending SMS via Promotexter API'
  s.description = 'The gem provides a simple way of sending SMS via Promotexter API'
  s.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = 'https://rubygems.org/gems/qiksms'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  s.require_paths = ['lib']

  s.add_development_dependency 'bundler', '~> 1.16'
  s.add_development_dependency 'dotenv', '~> 2.5.0'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 3.4.2'
end
