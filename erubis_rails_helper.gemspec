# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{erubis_rails_helper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dave Elkins"]
  s.date = %q{2009-06-12}
  s.description = %q{Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3.}
  s.email = %q{dave@elkinsware.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/elkinsware/erubis_rails_helper/tree/master}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Drop in replacement for the Rails integration in the Erubis gem so that Erubis will work with Rails 2.3.}
  s.test_files = [
    "test/test_erubis_rails_helper.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<actionpack>, [">= 2.2.2"])
      s.add_runtime_dependency(%q<erubis>, [">= 2.6.2"])
    else
      s.add_dependency(%q<actionpack>, [">= 2.2.2"])
      s.add_dependency(%q<erubis>, [">= 2.6.2"])
    end
  else
    s.add_dependency(%q<actionpack>, [">= 2.2.2"])
    s.add_dependency(%q<erubis>, [">= 2.6.2"])
  end
end
