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

  spec.add_runtime_dependency 'http', '<3'
  spec.add_runtime_dependency 'virtus', '<2'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.10"
  spec.add_development_dependency "dotenv", "~> 2.2"
  spec.add_development_dependency "byebug", "~> 9.0"
  spec.add_development_dependency "webmock", "~> 2.3"
end
