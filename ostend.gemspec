$:.push File.expand_path("../lib", __FILE__)
require "ostend/version"

Gem::Specification.new do |s|
  s.name          = 'ostend'
  s.authors       = ["Jeff Gandt"]
  s.email         = 'jeff@jgandt.com'
  s.version       = Ostend::VERSION
  s.date          = '2012-02-17'
  s.license       = 'MIT'

  s.summary       = "Objectify From a Hash"
  s.description   = "This is a set of tools to help instantiating objects with a hash"
  s.homepage      = 'https://github.com/jgandt/objectify_from_hash'

  s.require_paths = ["lib"]
  s.test_files    = Dir.glob('spec/*_spec.rb')
end
