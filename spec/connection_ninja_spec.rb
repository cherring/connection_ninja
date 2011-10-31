require 'spec/spec_helper'

describe ActiveRecord::Base, "methods" do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
  end

  it "should have configurtions" do
    ActiveRecord::Base.configurations.should_not == {}
  end

  it "should have connection ninja methods" do
    ActiveRecord::Base.should respond_to(:use_connection_ninja)
  end
end

describe ConnectionNinja::Orms::ActiveRecord, "exception" do
  it "should raise an error if connection group not in database.yml" do
    lambda{ActiveRecord::Base.use_connection_ninja(:fial)}.should raise_error(::ActiveRecord::AdapterNotFound)
  end
end

describe Customer do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
    @connection = Customer.establish_connection
  end

  it "should be connected to the alternate database" do
    Customer.connection.current_database.should == "ninja_one"
  end
end

describe Order do
  before do
    ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
    @connection = Order.send(:use_connection_ninja, :other)
  end

  it "should return correct configuration" do
    Order.send(:ninja_config, :other).should == {"username"=>"rails", "adapter"=>"postgresql", "database"=>"ninja_two", "host"=>"localhost", "password"=>"rails"}
  end

  it "should be connected to the default database" do
    Order.connection.current_database.should == "ninja_two"
  end
end

