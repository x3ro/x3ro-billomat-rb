# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{billomat-rb}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ronald Becher"]
  s.date = %q{2010-03-30}
  s.description = %q{A neat ruby library for interacting with the RESTfull API of billomat}
  s.email = %q{rb@ronald-becher.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.textile"
  ]
  s.files = [
    ".gitignore",
     "README.textile"
  ]
  s.homepage = %q{http://github.com/rbecher/billomat-rb}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{billomat-rb}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby library for interacting with the RESTfull billomat api.}
  s.test_files = [
    "test/billomat-rb_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_runtime_dependency(%q<activeresource>, [">= 2.3.2"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.2"])
      s.add_dependency(%q<activeresource>, [">= 2.3.2"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.2"])
    s.add_dependency(%q<activeresource>, [">= 2.3.2"])
  end
end
