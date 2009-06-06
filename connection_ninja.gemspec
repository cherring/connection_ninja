# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{connection_ninja}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Herring"]
  s.date = %q{2009-06-06}
  s.description = %q{Inject a new connection to an alternate database into an ActiveRecord Model at runtime}
  s.email = %q{chris.herring.iphone@gmail.com}
  s.extra_rdoc_files = ["CHANGELOG", "lib/connection_ninja.rb", "README.markdown"]
  s.files = ["CHANGELOG", "config/connection_ninja.yml", "connection_ninja.gemspec", "lib/connection_ninja.rb", "Manifest", "Rakefile", "README.markdown", "spec/connection_ninja_spec.rb", "spec/fixtures/models.rb", "spec/fixtures/structure.sql", "spec/spec_helper.rb", "spec/test_helper.rb"]
  s.homepage = %q{http://github.com/cherring/connection_ninja}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Connection_ninja", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{connection_ninja}
  s.rubygems_version = %q{1.3.3}
  s.summary = %q{Inject a new connection to an alternate database into an ActiveRecord Model at runtime}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
