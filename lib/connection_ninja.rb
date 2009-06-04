require 'yaml'

module ConnectionNinja
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    attr_accessor :connection_ninja_config_file
    attr_accessor :connection_ninja_config
    
    def use_connection_ninja(database)
      @connection_ninja_config = load_config("#{RAILS_ROOT}/config/connection_ninja.yml", database)
      @connection_ninja_config["password"] ||= ""
      establish_connection(
        :adapter => @connection_ninja_config["adapter"],
        :database => @connection_ninja_config["database"],
        :user => @connection_ninja_config["user"],
        :password => @connection_ninja_config["password"],
        :host => @connection_ninja_config["host"]
      )
    end
    
    def load_config(file, database)
      @connection_ninja_config_file = YAML::load_file(file)
      database_config = "#{database.to_s}_#{RAILS_ENV}"
      @connection_ninja_config_file[database_config]
    end
        
  end
end

ActiveRecord::Base.class_eval do
  include ConnectionNinja
end