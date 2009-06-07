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
end

describe Customer,"config" do
  
  it "should return the database config" do
    Customer.config(:alternate).should == ActiveRecord::Base.configurations['alternate_development']
  end
end


describe Customer,"use_connection_ninja" do  

  it "should call connect_to_db" do
    Customer.stub!(:config).and_return(ActiveRecord::Base.configurations['alternate_development'])
    Customer.should_receive(:connect_to_db).with(Customer.config)
    Customer.use_connection_ninja(:alternate)
  end
  
end

describe Customer,"connect_to_db" do
  
  it "should call establish_connection" do
    Customer.should_receive(:establish_connection)
    Customer.connect_to_db('alternate_development')
  end
end