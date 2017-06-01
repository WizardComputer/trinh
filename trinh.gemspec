$:.push File.expand_path("../lib", __FILE__)
require "trinh/version"

Gem::Specification.new do |s|
  s.name        = "trinh"
  s.version     = Trinh::VERSION
  s.authors     = ["Dino Maric"]
  s.licenses    = ['MIT']
  s.email       = ["dino.onex@gmail.com"]
  s.homepage    = "https://github.com/"
  s.summary     = "Generates next number based on scope and created date"
  s.description = "Concurent safe way to generate unique number based on number of rows in a table....."

  s.files = `git ls-files`.split("\n")
  s.test_files = Dir["test/**/*"]

  s.add_dependency "activesupport", ">= 3.0"
  s.add_dependency "activerecord", ">= 3.0"
  s.add_development_dependency "rails", ">= 3.1"
end
