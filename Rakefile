require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'yard'

task :default => [:build]

$gem_name = "billomat-rb"
 

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "billomat-rb"
    gem.summary = "Ruby library for interacting with the RESTfull billomat api."
    gem.description = "A neat ruby library for interacting with the RESTfull API of billomat"
    gem.email = "rb@ronald-becher.com"
    gem.homepage = "http://github.com/rbecher/billomat-rb"
    gem.authors = ["Ronald Becher"]
    gem.rubyforge_project = "billomat-rb"
    gem.add_dependency(%q<activesupport>, [">= 3.2.3"])
    gem.add_dependency(%q<activeresource>, [">= 3.2.3"])
  end
  Jeweler::RubyforgeTasks.new do |rubyforge|
    rubyforge.doc_task = "rdoc"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end


desc "Run tests"
Rake::TestTask.new do |t|
  t.libs << 'test'
end


YARD::Rake::YardocTask.new do |t|
end
