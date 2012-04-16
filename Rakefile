require 'rubygems'
require 'rake'
require 'rake/testtask'

task :default => [:build]

$gem_name = "billomat-rb"
 
#desc "Run specs"
#task :spec do
#  sh "spec spec/* --format specdoc --color"
#end

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

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "billomat-rb #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


desc "Run tests"
Rake::TestTask.new do |t|
  # Make sure API credentials for the unit tests are supplied
  if ENV['ACC'].nil? or ENV['KEY'].nil?
    abort("\n\n Please call using 'KEY={billomatApiKey} ACC={billomatAccount} rake test'\n\n") 
  end

  t.libs << 'test'
end

