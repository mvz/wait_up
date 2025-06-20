# frozen_string_literal: true

require_relative "lib/wait_up/version"

Gem::Specification.new do |spec|
  spec.name = "wait_up"
  spec.version = WaitUp::VERSION
  spec.authors = ["Matijs van Zuijlen"]
  spec.email = ["matijs@matijs.net"]

  spec.summary = "Play sound files slowly so you can follow along"
  spec.homepage = "http://www.github.com/mvz/wait_up"

  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = File.read("Manifest.txt").split
  spec.bindir = "bin"
  spec.executables = %w[wait_up wait_up-cli]
  spec.require_paths = ["lib"]

  spec.rdoc_options = ["--main", "README.md"]
  spec.extra_rdoc_files = ["README.md", "Changelog.md"]

  spec.add_dependency "gstreamer", "~> 4.2.0"
  spec.add_dependency "gtk3", "~> 4.2.0"

  spec.add_development_dependency "gnome_app_driver", "~> 0.3.2"
  spec.add_development_dependency "minitest", "~> 5.12"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rake-manifest", "~> 0.2.0"
  spec.add_development_dependency "rubocop", "~> 1.76"
  spec.add_development_dependency "rubocop-minitest", "~> 0.38.0"
  spec.add_development_dependency "rubocop-packaging", "~> 0.6.0"
  spec.add_development_dependency "rubocop-performance", "~> 1.25"
end
