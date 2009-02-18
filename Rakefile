require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Runs unit test suite.'
Rake::TestTask.new do |test|
  test.libs << './test'
  test.test_files = FileList['test/unit/*test.rb']
  test.verbose = true
end

desc 'Runs Ruby Standard Library tests for date and time.'
task :test_ruby do 
  puts `mspec test/spec`
end

desc 'Generate documentation for the smart_month plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SmartMonth'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
