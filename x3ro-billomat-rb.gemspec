# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "x3ro-billomat-rb"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lucas Jenss"]
  s.date = "2013-02-05"
  s.email = "lucas@x3ro.de"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".yardopts",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "TODO.textile",
    "VERSION",
    "lib/billomat-rb.rb",
    "lib/billomat/base.rb",
    "lib/billomat/exceptions.rb",
    "lib/billomat/read_only_singleton_base.rb",
    "lib/billomat/resource_types.rb",
    "lib/billomat/resources/article.rb",
    "lib/billomat/resources/client.rb",
    "lib/billomat/resources/creditnote.rb",
    "lib/billomat/resources/invoice.rb",
    "lib/billomat/resources/offer.rb",
    "lib/billomat/resources/offeritem.rb",
    "lib/billomat/resources/settings.rb",
    "lib/billomat/resources/unit.rb",
    "lib/billomat/resources/user.rb",
    "lib/billomat/singleton_base.rb",
    "test/test_billomat.rb",
    "x3ro-billomat-rb.gemspec"
  ]
  s.homepage = "http://github.com/x3ro/x3ro-billomat-rb"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A library for interacting with the RESTful API of Billomat"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activeresource>, ["~> 3.2.8"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_development_dependency(%q<yard>, ["~> 0.8.2"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
      s.add_development_dependency(%q<turn>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<activeresource>, ["~> 3.2.8"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
      s.add_dependency(%q<yard>, ["~> 0.8.2"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
      s.add_dependency(%q<turn>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activeresource>, ["~> 3.2.8"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.4"])
    s.add_dependency(%q<yard>, ["~> 0.8.2"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
    s.add_dependency(%q<turn>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

