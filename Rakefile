require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('connection_ninja', '0.1.0') do |p|
  p.description     = "Inject a new connection to an alternate database into an ActiveRecord Model at runtime"
	p.url             = "http://github.com/cherring/connection_ninja"
	p.author          = "Chris Herring"
	p.email           = "chris.herring.iphone@gmail.com"
	p.ignore_pattern  = ["tmp/*", "script/*"]
	p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
