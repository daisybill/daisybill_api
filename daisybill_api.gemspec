$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "daisybill_api/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "daisybill_api"
  s.version     = DaisybillApi::VERSION
  s.authors     = ["Ben Liscio"]
  s.email       = ["bliscio@daisybill.com"]
  s.homepage    = "https://api.daisybill.com"
  s.summary     = "ActiveRecord style wrapper for DaisyBill's API"
  s.description = "ActiveRecord style wrapper for DaisyBill's API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"
end

