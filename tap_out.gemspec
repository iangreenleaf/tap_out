# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "tap_out/version"

Gem::Specification.new do |s|
  s.name        = "tap_out"
  s.version     = TapOut::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ian Young"]
  s.email       = ["ian.greenleaf@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TAP harness for Test::Unit}
  s.description = %q{Use Test::Unit to run anything that uses the Test Anything Protocol.}

  s.rubyforge_project = "tap_out"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
