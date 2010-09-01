$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
require 'rspec/autorun'

require 'rails'
require 'active_record'
require 'connection_ninja/active_record'
require 'connection_ninja'

#require 'spec/fixtures/models'
#require 'spec/test_helper'

FileUtils.mkdir_p "#{Dir.pwd}/tmp"
ActiveRecord::Base.logger         = Logger.new(StringIO.new)
ActiveRecord::Base.configurations = YAML.load_file(File.join("spec", "fixtures", "database.yml"))

Rspec.configure do |config|
  #test = TestHelper.new
  #test.setup_postgresql
  
end
