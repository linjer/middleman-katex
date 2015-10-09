# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'middleman-katex/version'

Gem::Specification.new do |s|
  s.name        = "middleman-katex"
  s.version     = Middleman::Katex::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jerry Lin"]
  s.email       = ["linjer@gmail.com"]
  s.homepage    = "https://github.com/linjer/middleman-katex"
  s.summary     = %q{Math and equation typesetting via KaTeX for Middleman sites}
  s.description = %q{Math and equation typesetting via KaTeX for Middleman sites}

  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables           = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths         = ["lib"]
  s.required_ruby_version = '>= 2.1.1'

  s.add_runtime_dependency("middleman-core", [">= 4.0.0.rc.2"])
  s.add_development_dependency("haml")
  s.add_development_dependency("slim")
  s.add_development_dependency("rubocop")
end
