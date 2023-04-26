# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tito/version'

Gem::Specification.new do |spec|
  spec.name          = "tito"
  spec.version       = Tito::VERSION
  spec.authors       = ["Paul Campbell"]
  spec.email         = ["paul@rslw.com"]

  spec.summary       = %q{Consumer library for Tito API}
  spec.description   = %q{Allows interaction with the Tito API}
  spec.homepage      = "http://api.tito.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "http", "~> 5.1.1"
  spec.add_runtime_dependency "virtus", "~> 2.0.0"

  spec.add_development_dependency "bundler", "~> 2.4.1"
  spec.add_development_dependency "rake", "~> 13.0.6"
  spec.add_development_dependency "minitest", "~> 5.18.0"
  spec.add_development_dependency "dotenv", "~> 2.8.1"
  spec.add_development_dependency "byebug", "~> 11.1.3"
  spec.add_development_dependency "webmock", "~> 3.18.1"
end
