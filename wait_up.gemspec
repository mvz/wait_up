# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = "wait_up"
  s.version = "0.1.0"

  s.summary = "Play sound files slowly so you can follow along"

  s.authors = ["Matijs van Zuijlen"]
  s.email = ["matijs@matijs.net"]
  s.homepage = "http://www.github.com/mvz/wait_up"

  s.required_ruby_version = ">= 2.5.0"

  s.executables = %w(wait_up wait_up-cli)
  s.files = File.read("Manifest.txt").split
  s.rdoc_options = ["--main", "README.md"]
  s.extra_rdoc_files = ["README.md", "Changelog.md"]

  s.license = "MIT"

  s.add_dependency("gstreamer", ["~> 3.4.0"])
  s.add_dependency("gtk3", ["~> 3.4.0"])

  s.add_development_dependency("gnome_app_driver", ["~> 0.2.0"])
  s.add_development_dependency("minitest", ["~> 5.12"])
  s.add_development_dependency("rake", ["~> 13.0"])
  s.add_development_dependency("rake-manifest", ["~> 0.1.0"])
  s.add_development_dependency("rubocop", ["~> 0.90.0"])
  s.add_development_dependency("rubocop-minitest", ["~> 0.10.0"])
  s.add_development_dependency("rubocop-packaging", ["~> 0.4.0"])
  s.add_development_dependency("rubocop-performance", ["~> 1.7.0"])
end
