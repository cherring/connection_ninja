require 'yaml'

module ConnectionNinja
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    # These are just here to use to run my specs, will work out how to fake these later
    # RAILS_ENV = "development"
    # RAILS_ROOT = File.dirname(__FILE__) + "/.."
    attr_accessor :connection_ninja_config_file
    attr_accessor :connection_ninja_config
    
    def use_connection_ninja(database)
      @connection_ninja_config = load_config("#{RAILS_ROOT}/config/connection_ninja.yml", database)
      connect_to_db if config_ok?
    end
    
    def load_config(file, database)
      @connection_ninja_config_file = YAML::load_file(file)
      @connection_ninja_config_file["#{database.to_s}_#{RAILS_ENV}"]
    end
    
    def config_ok?
      @connection_ninja_config.each_pair do |key, value|
        if (key == "adapter" || key == "database" || key == "user") && value.nil?
          raise "You have an error in your connection_ninja.yml."
        elsif (key == "host") && value.nil?
          @connection_ninja_config["host"] = "localhost"
        elsif (key == "password") && value.nil?
          @connection_ninja_config["password"] = ""
        end
      end
      true
    end
    
    def connect_to_db
      establish_connection(
        :adapter => @connection_ninja_config["adapter"],
        :database => @connection_ninja_config["database"],
        :user => @connection_ninja_config["user"],
        :password => @connection_ninja_config["password"],
        :host => @connection_ninja_config["host"]
      )
    end
        
  end
end

ActiveRecord::Base.class_eval do
  include ConnectionNinja
end