# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hanko/version'

Gem::Specification.new do |spec|
  spec.name          = "hanko"
  spec.version       = Hanko::VERSION
  spec.authors       = ["tsukasaoishi"]
  spec.email         = ["tsukasa.oishi@gmail.com"]

  spec.summary       = %q{Add digest fingerprint (SHA256, MD5 and so on) in query string of Rails asset url.}
  spec.description   = %q{Hanko add a asset fingerprint in query string of Rails asset url(image, javascript, stylesheet, etc).}
  spec.homepage      = "https://github.com/tsukasaoishi/hanko"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2", "< 5.2"

  spec.add_development_dependency "bundler", '>= 1.3.0', '< 2.0'
  spec.add_development_dependency "rake", '>= 0.8.7'
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "minitest-reporters"
  spec.add_development_dependency 'appraisal'
end
