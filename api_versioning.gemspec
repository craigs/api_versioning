$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "api_versioning/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|

  s.name          = "api_versioning"
  s.version       = ApiVersioning::VERSION
  s.authors       = ["Craig Sullivan"]
  s.email         = ["craig@melbourne-systems.com"]
  s.description   = %q{API versioning for rails projects. An extraction from the launch.ly project}
  s.summary       = %q{A model based approach to have versioned APIs.}
  s.homepage      = "launch.ly"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency "jbuilder"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rake'
  s.add_development_dependency "minitest-rails"
  s.add_development_dependency 'minitest-rails-capybara'
  s.add_development_dependency 'capybara'
#  s.add_development_dependency 'capybara_minitest_spec'
  s.add_development_dependency 'turn'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'forgery'

end
