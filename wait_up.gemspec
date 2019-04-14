# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'wait_up'
  s.version = '0.1.0'

  s.summary = 'Play sound files slowly so you can follow along'

  s.authors = ['Matijs van Zuijlen']
  s.email = ['matijs@matijs.net']
  s.homepage = 'http://www.github.com/mvz/wait_up'

  s.required_ruby_version = '>= 2.4.0'

  s.executables = ['wait_up', 'wait_up-cli']
  s.files =
    Dir['bin/*', '*.md', 'LICENSE', 'Rakefile', 'Gemfile', 'lib/**/*.rb'] &
    `git ls-files -z`.split("\0")
  s.test_files = Dir['test/**/*.rb']

  s.license = 'MIT'

  s.add_dependency('gstreamer', ['~> 3.3.0'])
  s.add_dependency('gtk3', ['~> 3.3.0'])
  s.add_development_dependency('gnome_app_driver', ['~> 0.2.0'])
  s.add_development_dependency('minitest', ['~> 5.5'])
  s.add_development_dependency('rake', ['~> 12.0'])
end
