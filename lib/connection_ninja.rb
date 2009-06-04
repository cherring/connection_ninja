require 'yaml'

module ConnectionNinja
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    attr_accessor :connection_ninja_config
    def use_connection_ninja(database)

    end    
  end

  def load_config(file, database)
    @connection_ninja_config = YAML::load_file(file)
    database_config = "#{database.to_s}_#{RAILS_ENV}"
    @connection_ninja_config[database_config]
  end
end

ActiveRecord::Base.class_eval do
  include ConnectionNinja
end