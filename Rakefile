# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "x3ro-billomat-rb"
  gem.homepage = "http://github.com/x3ro/x3ro-billomat-rb"
  gem.license = "MIT"
  gem.summary = %Q{A library for interacting with the RESTful API of Billomat}
  #gem.description = %Q{}
  gem.email = "lucas@x3ro.de"
  gem.authors = ["Lucas Jenss"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

#require 'rcov/rcovtask'
#Rcov::RcovTask.new do |test|
#  test.libs << 'test'
#  test.pattern = 'test/**/test_*.rb'
#  test.verbose = true
#  test.rcov_opts << '--exclude "gems/*"'
#end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new do |t|
end


# A convenience console task that loads and authenticates the Billomat library.
# If you supply the "debug" option ("rake console debug") the Net::HTTP requests
# being sent to the API endpoints will be verbosely displayed.
Rake::Task["console"].clear
task :console do
  require 'irb'
  require 'pp'
  require './lib/billomat-rb'

  # Make sure API credentials for the unit tests are supplied
  if ENV['ACC'].nil? or ENV['KEY'].nil?
    abort("\n\n Please call using 'KEY={billomatApiKey} ACC={billomatAccount} rake test'\n\n")
  end
  Billomat.account = ENV['ACC']
  Billomat.key = ENV['KEY']
  ARGV.shift # Remove task name from command line parameter list
  debug = ARGV[0] == "debug" && ARGV.shift

  # Enable Net/HTTP request debugging, as in Gist
  # https://gist.github.com/591601
  if debug
    require 'net/http'
    module Net
      class HTTP
        def self.enable_debug!
          class << self
            alias_method :__new__, :new
            def new(*args, &blk)
              instance = __new__(*args, &blk)
              instance.set_debug_output($stderr)
              instance
            end
          end
        end

        def self.disable_debug!
          class << self
            alias_method :new, :__new__
            remove_method :__new__
          end
        end
      end
    end
    Net::HTTP.enable_debug!
  end

  IRB.start
end
