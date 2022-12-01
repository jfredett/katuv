# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'katuv/version'

Gem::Specification.new do |gem|
  gem.name          = "katuv"
  gem.version       = Katuv::VERSION
  gem.authors       = ["Joe Fredette"]
  gem.email         = ["jfredett@gmail.com"]
  gem.description   = %q{A tool for parsing and transforming internal Ruby DSLs}
  gem.summary       = %q{A tool for parsing and transforming internal Ruby DSLs}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'ast', '~> 1'
end
