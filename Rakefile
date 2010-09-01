require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "connection_ninja"
    gem.summary = %Q{Handle multiple Database conenctions with ActiveRecord Models}
    gem.description = %Q{Handle multiple Database conenctions with ActiveRecord Models}
    gem.email = "chris.herring.iphone@gmail.com"
    gem.homepage = "http://github.com/cherring/connection_ninja"
    gem.authors = ["Chris Herring"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta19"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "connection ninja #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
