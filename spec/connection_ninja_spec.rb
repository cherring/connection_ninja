require 'spec/spec_helper'
require 'connection_ninja'
include ConnectionNinja

describe Order do
  
  it "should be connected to the default database" do
    Order.connection.current_database.should == "connection_ninja"
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
  
  it "should have the config details" do
    Customer.use_connection_ninja(:alternate)
    Customer.connection_ninja_config.should_not be_nil
  end
  
  it "should call config_ok?" do
    Customer.stub!(:config_ok?)
    Customer.should_receive(:config_ok?)
    Customer.use_connection_ninja(:alternate)
  end

  it "should call connect_to_db" do
    Customer.stub!(:config_ok?).and_return(true)
    Customer.should_receive(:connect_to_db)
    Customer.use_connection_ninja(:alternate)
  end
  
  it "should call load_config" 
  # do
  #   Customer.should_receive(:load_config)
  #   Customer.use_connection_ninja(:alternate)
  # end
end

describe Customer,"connect_to_db" do
  
  it "should call establish_connection" do
    Customer.load_config("#{RAILS_ROOT}/config/connection_ninja.yml", :alternate)
    Customer.stub!(:establish_connection)
    Customer.should_receive(:establish_connection)
    Customer.connect_to_db
  end
end

describe Customer,"check_config" do
  before do
    Customer.load_config("#{RAILS_ROOT}/config/connection_ninja.yml", :alternate)
  end
  
  it "should raise an error if no apdapter given" do
    Customer.connection_ninja_config["adapter"] = nil
    lambda{ Customer.config_ok? }.should raise_error("You have an error in your connection_ninja.yml.")
  end
  
  it "should raise an error if no database given" do
    Customer.connection_ninja_config["adapter"] = "postgresql"
    Customer.connection_ninja_config["database"] = nil
    lambda{ Customer.config_ok? }.should raise_error("You have an error in your connection_ninja.yml.")
  end
  
  it "should set the password to blank if it's nil" do
    Customer.connection_ninja_config["database"] = "connection_ninja_alternate"
    Customer.connection_ninja_config["password"] = nil
    Customer.config_ok?
    Customer.connection_ninja_config["password"].should == ""
  end
  
  it "should raise an error if no user given" do
    Customer.connection_ninja_config["database"] = "connection_ninja_alternate"
    Customer.connection_ninja_config["user"] = nil
    lambda{ Customer.config_ok? }.should raise_error("You have an error in your connection_ninja.yml.")
  end
  
  it "should set the host to localhost if none provided" do
    Customer.connection_ninja_config["user"] = "chris"
    Customer.connection_ninja_config["host"] = nil
    Customer.config_ok?
    Customer.connection_ninja_config["host"].should == "localhost"
  end
end