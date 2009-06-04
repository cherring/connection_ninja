# Inspiration gained from Thinking Sphinx's test suite via Ryan Bigg's by_star test suite.

$:.unshift File.dirname(__FILE__) + '/../lib'

require 'rubygems'
require 'activerecord'
require 'connection_ninja'
require 'spec/fixtures/models'
require 'spec/test_helper'

FileUtils.mkdir_p "#{Dir.pwd}/tmp"

ActiveRecord::Base.logger = Logger.new(StringIO.new)

Spec::Runner.configure do |config|  
  test = TestHelper.new
  test.setup_postgresql
  RAILS_ENV = "development"
  PROJECT_ROOT = File.dirname(__FILE__) + "/../"
end