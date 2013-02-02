# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ostend/version'

Gem::Specification.new do |s|
  s.name          = "ostend"
  s.version       = Ostend::VERSION
  s.authors       = ["Jeff Gandt"]
  s.email         = ["jeff.gandt@gmail.com"]
  s.description   = "This is a set of tools to help instantiating objects with a hash"
  s.summary       = "Objectify From a Hash"
  s.license       = 'EPL'
  s.homepage      = 'https://github.com/jgandt/ostend'


  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
end
