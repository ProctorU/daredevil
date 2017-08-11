$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "daredevil/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "daredevil"
  s.version     = Daredevil::VERSION
  s.authors     = ["Kevin Brown"]
  s.email       = ["chevinbrown@gmail.com"]
  s.homepage    = "http://github.com/proctoru/daredevil"
  s.summary     = "JSON API errors insight."
  s.description = "Daredevil provides insight into JSON API errors with friendly messages, verbose error details, and it's dead simple."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.2.8"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "active_model_serializers"
end
