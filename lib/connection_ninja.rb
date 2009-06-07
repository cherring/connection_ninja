module ConnectionNinja
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    # These are just here to use to run my specs, will work out how to fake these later
    RAILS_ENV = "development"
    RAILS_ROOT = File.dirname(__FILE__) + "/.."
    
    def use_connection_ninja(database_config)
      connect_to_db(config(database_config))
    end
    
    def config(database_config)
      ActiveRecord::Base.configurations["#{database_config.to_s}_#{RAILS_ENV}"]
    end
        
    def connect_to_db(config)
      establish_connection(config)
    end
        
  end
end

ActiveRecord::Base.class_eval do
  include ConnectionNinja
end