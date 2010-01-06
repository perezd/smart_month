require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "smart_month"
    gemspec.summary = 'SmartMonth is a "bodysnatcher" plugin that takes boring Date month fixnums and replaces them with a rich toolkit of
functionality.'
    gemspec.description = "You can use SmartMonth to: \n" +
    "- Determine the first tuesday of any month in any year. \n" +
    "- Determine all of the fridays of any month in any year. \n" +
    "- Iterate through all the days of a month. \n" +
    "- Determine how many days of the month there are. \n" +
    "- Determine the first and last days of the month. \n" +
    "- And other fun date/month related things!"
    gemspec.email = "derek@derekperez.com"
    gemspec.homepage = "http://github.com/perezd/smart_month"
    gemspec.authors = ["Derek Perez", "Jonathan Silverman"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end


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

