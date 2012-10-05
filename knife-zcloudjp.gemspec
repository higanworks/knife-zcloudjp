# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife-zcloudjp/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["sawanoboly"]
  gem.email         = ["sawanoboriyu@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "knife-zcloudjp"
  gem.require_paths = ["lib"]
  gem.version       = Knife::Zcloudjp::VERSION
  gem.add_dependency "chef", ">= 0.10.10"
  gem.add_dependency "faraday"
  gem.add_development_dependency 'pry'
end
