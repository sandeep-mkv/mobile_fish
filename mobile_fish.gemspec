# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobile_fish/version'

Gem::Specification.new do |spec|
  spec.name          = "mobile_fish"
  spec.version       = MobileFish::VERSION
  spec.authors       = ["Sandeep Venugopal"]
  spec.email         = ["sandeep.mkv@gmail.com"]

  spec.summary       = %q{This gem is an implementation of 1800-CODING-CHALLENGE}
  spec.homepage      = "https://github.com/sandeep-mkv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-reporters", "1.1.11"
  spec.add_development_dependency "byebug", "9.0.5"
  spec.add_development_dependency "minitest-stub_any_instance", "~> 1.0.1"
end
