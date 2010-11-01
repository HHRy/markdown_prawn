require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = './test/*.rb'
  t.verbose = true
end
Rake::Task['test'].comment = "Test Markdown Prawn"

task :default => [:test]
