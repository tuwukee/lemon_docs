lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lemon_docs/version'

Gem::Specification.new do |s|
  s.name          = 'lemon_docs'
  s.version       = LemonDocs::VERSION
  s.date          = '2016-01-21'
  s.summary       = 'Lemon Docs'
  s.description   = 'Markdown based documentation'
  s.authors       = ['Yulia Oletskaya']
  s.email         = 'yulia.oletskaya@gmail.com'

  s.files         = Dir['lib/**/*']
  s.files         << Dir['*']
  s.files         << Dir['ext/drafter/**/*'].reject { |f| f =~ /cmdline|test|features|README*|LICENSE|Gemfile*|\.xcode*/ }
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.homepage      = 'http://rubygems.org/gems/lemon_docs'
  s.license       = 'MIT'

  s.add_dependency 'ffi', '~> 1.9'
  s.add_dependency 'rake', '~> 11.3'
  s.add_dependency 'bundler', '~> 1.8'
  s.add_dependency 'redcarpet'
end
