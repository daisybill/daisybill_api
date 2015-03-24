$:.push File.expand_path("../lib", __FILE__)

require "daisybill_api/version"

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
  s.test_files = Dir["spec/**/*_spec.rb"]

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "activemodel"

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"
  s.add_development_dependency "ffaker"
  s.add_development_dependency "rspec-collection_matchers"
end

