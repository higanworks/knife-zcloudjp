# -*- encoding: utf-8 -*-
require File.expand_path('../lib/knife-zcloudjp', __FILE__)

Gem::Specification.new do |s|
  s.version       = Knife::Zcloudjp::VERSION
  s.authors       = ["sawanoboly"]
  s.email         = ["sawanoboriyu@gmail.com"]
  s.description   = %q{Knife(Opscode Chef) plugin for Z Cloud(Powered by Joyent).}
  s.summary       = %q{Knife(Opscode Chef) plugin for Z Cloud(Powered by Joyent).}
  s.homepage      = "https://github.com/higanworks/knife-zcloudjp"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.name          = "knife-zcloudjp"
  s.require_paths = ["lib"]

  s.add_dependency "chef", ">= 0.10.10"
  s.add_dependency "zcloudjp"
  s.add_dependency "formatador"

  s.add_development_dependency("rspec", [">= 2.2.0"])
  s.add_development_dependency("rake")
  s.add_development_dependency("fuubar")
  s.add_development_dependency("pry")
  s.add_development_dependency("pry-doc")
  s.add_development_dependency("cane")
end
