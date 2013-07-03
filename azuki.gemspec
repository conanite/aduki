# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'azuki/version'

Gem::Specification.new do |gem|
  gem.name          = "azuki"
  gem.version       = Azuki::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/conanite/azuki"

  gem.add_development_dependency 'rspec', '~> 2.9'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
