require 'rake'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Runs tiny test suite.'
task :test do 
  ruby 'test.rb'
end

desc 'Generate documentation for the smart_month plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SmartMonth'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
