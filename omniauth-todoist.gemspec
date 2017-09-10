# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/todoist/version'

Gem::Specification.new do |s|
  s.name          = "omniauth-todoist"
  s.version       = Omniauth::Todoist::VERSION
  s.authors       = ["Bethany Soule"]
  s.email         = ["bsoule@beeminder.com"]

  s.summary       = %q{OmniAuth strategy for Todoist}
  s.description   = %q{OmniAuth strategy for Todoist}
  s.homepage      = "https://github.com/beeminder/omniauth-todoist"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "omniauth", ">= 1.1.1"
  s.add_runtime_dependency "omniauth-oauth2", ">= 1.3.1"

  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
