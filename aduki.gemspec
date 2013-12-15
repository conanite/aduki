# -*- coding: utf-8; mode: ruby  -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'aduki/version'

Gem::Specification.new do |gem|
  gem.name          = "aduki"
  gem.version       = Aduki::VERSION
  gem.authors       = ["Conan Dalton"]
  gem.license       = 'MIT'
  gem.email         = ["conan@conandalton.net"]
  gem.description   = %q{recursive attribute setting for ruby objects}
  gem.summary       = %q{set object attributes recursively from an attributes hash}
  gem.homepage      = "https://github.com/conanite/aduki"


  gem.add_development_dependency 'rspec', '~> 2.9'
  gem.add_development_dependency 'rspec_numbering_formatter'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
