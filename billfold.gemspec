# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = 'billfold'
  gem.version = '0.0.0'
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
end
