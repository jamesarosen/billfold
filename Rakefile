require 'rubygems'
require 'rake'

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'app/controllers' << 'app/mailers' << 'app/models' << 'lib'
  t.pattern = 'test_app/test/**/*_test.rb'
  t.verbose = true
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Billfold #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('Gemfile')
  rdoc.rdoc_files.include('app/**/*.rb')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => :test
