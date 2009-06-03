require 'spec/spec_helper'
require 'connection_ninja'
include ConnectionNinja

describe Order do
  it "should be connected to the default database" do
    Order.connection.current_database.should == "connection_ninja"
  end
end

describe Customer do
  it "should be connected to the default database" do
    Customer.connection.current_database.should == "connection_ninja"
  end
end