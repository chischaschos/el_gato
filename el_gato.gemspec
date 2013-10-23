# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'el_gato/version'

Gem::Specification.new do |spec|
  spec.name          = 'el_gato'
  spec.version       = ElGato::VERSION
  spec.authors       = ['chischaschos']
  spec.email         = ['larin.s931@gmail.com']
  spec.description   = %q{A drb implementation of the tic tac toe game}
  spec.summary       = %q{A drb implementation of the tic tac toe game fot the CLI}
  spec.homepage      = 'https://github.com/chischaschos/el_gato'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'bare_gato'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'debugger'
end
