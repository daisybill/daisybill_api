$:.push File.expand_path("../lib", __FILE__)

require "daisybill_api/version"

Gem::Specification.new do |s|
  s.name        = "daisybill_api"
  s.version     = DaisybillApi::VERSION
  s.authors     = ["Ben Liscio", "Eugene Surzhko", "Joe Leo"]
  s.email       = ["bliscio@daisybill.com"]
  s.homepage    = "https://www.daisybill.com"
  s.summary     = "ActiveRecord style wrapper for DaisyBill's API"
  s.description = "ActiveRecord style wrapper for DaisyBill's API"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*_spec.rb"]

  s.add_runtime_dependency      "activemodel",                ">= 4.2"
  s.add_runtime_dependency      "rest-client",                "~> 2.0"

  s.add_development_dependency  "bundler",                    "~> 1.7"
  s.add_development_dependency  "ffaker",                     "~> 2.0"
  s.add_development_dependency  "rake",                       "~> 10.0"
  s.add_development_dependency  "rspec",                      "~> 3.2"
  s.add_development_dependency  "rspec-collection_matchers",  "~> 1.1"
  s.add_development_dependency  "rspec-its",                  "~> 1.2"
  s.add_development_dependency  "vcr",                        "~> 2.9"
  s.add_development_dependency  "webmock",                    "~> 1.20"
  s.add_development_dependency  "yard",                       "~> 0.9.0"
end

