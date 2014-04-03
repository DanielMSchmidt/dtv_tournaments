# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dtv_tournaments/version'

Gem::Specification.new do |spec|
  spec.name          = "dtv_tournaments"
  spec.version       = DtvTournaments::VERSION
  spec.authors       = ["Daniel Schmidt"]
  spec.email         = ["dschmidt@weluse.de"]
  spec.summary       = "A ruby gem for fetching tournaments from the dtv tournaments portal"
  spec.description   = "This gem fetches the appsrv.tanzsport.de/dtv-webdbs/turnier/suche.spf portal and gives all available informations about the tournaments"
  spec.homepage      = "https://github.com/DanielMSchmidt/dtv_tournaments"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "mechanize", "~> 2.7.2"
  spec.add_runtime_dependency "rails"
end
