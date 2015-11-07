# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'wait_up'
  s.version = '0.0.1'

  s.summary = 'Play sound files slowly so you can follow along'

  s.authors = ['Matijs van Zuijlen']
  s.email = ['matijs@matijs.net']
  s.homepage = 'http://www.github.com/mvz/wait_up'

  s.executables = ['wait_up']
  s.files =
    Dir['bin/*', '*.md', 'LICENSE', 'Rakefile', 'Gemfile', 'lib/**/*.rb'] &
      `git ls-files -z`.split("\0")
  s.test_files = Dir['test/**/*.rb']

  s.license = 'MIT'

  s.add_dependency('gir_ffi-gtk', ['~> 0.8.0'])
  s.add_dependency('gir_ffi-gst', ['~> 0.0.1'])
  s.add_dependency('gir_ffi', ['~> 0.8.3.pre1'])
  s.add_development_dependency('rake', ['~> 10.1'])
  s.add_development_dependency('minitest', ['~> 5.5'])
  s.add_development_dependency('atspi_app_driver', ['0.0.3'])
  s.add_development_dependency('pry', ['~> 0.10.2'])
end
