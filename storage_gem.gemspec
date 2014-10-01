# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'storage_gem/version'

Gem::Specification.new do |spec|
  spec.name          = "storage_gem"
  spec.version       = StorageGem::VERSION
  spec.authors       = ["dmishchuk"]
  spec.email         = ['vk.settings@gmail.com']
  spec.summary       = 'gem to work with prefix tree'
  spec.description   = 'This is the gem to work with prefix tree like dictionary'
  spec.homepage      = 'https://rubygems.org'
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "simplecov", "~> 0.9.1"
  spec.add_runtime_dependency "rubyzip", "~> 1.1.6"
  spec.add_runtime_dependency "spork", "~> 0.9.2"
end
