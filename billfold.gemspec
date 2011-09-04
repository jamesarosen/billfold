# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = 'billfold'
  gem.version = File.read('VERSION')
  gem.description = %q{Identity Management with OmniAuth}
  gem.summary = gem.description
  gem.email = ['james.a.rosen@gmail.com']
  gem.homepage = 'http://github.com/jamesarosen/billfold'
  gem.authors = ['James A. Rosen']
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') if gem.respond_to? :required_rubygems_version=

  gem.add_development_dependency  'rails',        '~> 3.1'
  gem.add_development_dependency  'bundler'
  gem.add_development_dependency  'mocha'
  gem.add_development_dependency  'rake'
  gem.add_development_dependency  'rspec-rails'
  gem.add_development_dependency  'sqlite3'
  gem.add_development_dependency  'factory_girl'
end
