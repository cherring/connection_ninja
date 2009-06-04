require 'spec/spec_helper'
require 'connection_ninja'
include ConnectionNinja

describe Order do
  
  it "should have 1 connection only on startup" do
    count =  ActiveRecord::Base.connection.select_all("select count(*) from pg_stat_activity")
    count = count[0]
    count["count"].to_i.should == 1
  end
  
  it "should be connected to the default database" do
    Order.connection.current_database.should == "connection_ninja"
  end
  
  it "should have RAILS_ENV development" do
    RAILS_ENV.should == "development"
  end
end

describe Customer do
  it "should be connected to the alternate database" do
    Customer.connection.current_database.should == "connection_ninja_alternate"
  end
  
  it "should respond to use_connection_ninja" do
    Customer.respond_to?(:use_connection_ninja).should == true
  end
  
  it "should respond to load_config" do
    Customer.respond_to?(:load_config).should be_true
  end
  
  it "should have RAILS_ENV development" do
    RAILS_ENV.should == "development"
  end
end

describe Customer,"load_config" do
  before do
    Customer.load_config("#{RAILS_ROOT}/config/connection_ninja.yml", :alternate)
  end
  
  it "should find the config file" do
    Customer.connection_ninja_config_file.should_not be_nil
  end
  
  it "should call YAML load file" do
    Customer.load_config("#{RAILS_ROOT}/config/connection_ninja.yml", :alternate).should_not be_nil
  end
end

describe Customer,"use_connection_ninja" do
  
  it "should return error messages for missing credentials"
  
  it "should have the config details" do
    Customer.use_connection_ninja(:alternate)
    Customer.connection_ninja_config.should_not be_nil
  end
  
  it "should not have a nil password" do
    Customer.use_connection_ninja(:alternate)
    Customer.connection_ninja_config["password"].should_not be_nil
  end
  
  it "should call establish_connection" do
    Customer.should_receive(:establish_connection)
    Customer.use_connection_ninja(:alternate)
  end
  
  it "should call load_config" 
  # do
  #   Customer.should_receive(:load_config)
  #   Customer.use_connection_ninja(:alternate)
  # end
end