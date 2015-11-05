# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cucumber/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "cucumber-rails2"
  spec.version       = Cucumber::Rails::VERSION
  spec.authors       = ["Steve Tooke"]
  spec.email         = ["steve@boxjump.co.uk"]

  spec.summary       = %q{Cucumber integration for rails.}
  spec.description   = %q{Cucumber integration for rails.}
  spec.homepage      = "http://cucumber.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "cucumber", [">= 2", "< 3"]
  spec.add_dependency "capybara", "~> 2.5"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "aruba", "~> 0.10"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "ammeter", "= 1.1.2"
end
