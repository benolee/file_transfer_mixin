# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "file_transfer_mixin/version"

Gem::Specification.new do |s|
  s.name        = "file_transfer_mixin"
  s.version     = FileTransferMixin::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josh Adams"]
  s.email       = ["josh@isotope11.com"]
  s.homepage    = ""
  s.summary     = %q{A mixin to include in various libraries to allow you to easily send/retrieve files from remote servers.}

  s.rubyforge_project = "file_transfer_mixin"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'net-sftp', '~> 2.0.5'
  s.add_dependency 'enviro', '~> 0.0.4'
  s.add_development_dependency "bundler", ">= 1.0.0.rc.6"
  s.add_development_dependency "rspec", "~> 2.4.0"
  s.add_development_dependency "ruby-debug19"
end
