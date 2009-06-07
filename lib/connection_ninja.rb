module ConnectionNinja
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    #These are just here to use to run my specs, will work out how to fake these later
    # RAILS_ENV = "development"
    #  RAILS_ROOT = File.dirname(__FILE__) + "/.."
    #  ActiveRecord::Base.configurations = { 'alternate_development' => { 
    #    'adapter' => 'postgresql',
    #    'database' => 'connection_ninja_alternate',
    #    'host' => 'localhost'
    #    }
    #  }
    
    def use_connection_ninja(config_name)
      connect_to_db(config(config_name))
    end
    
    def config(config)
      ActiveRecord::Base.configurations["#{config.to_s}_#{RAILS_ENV}"]
    end
      
    def connect_to_db(config)
      establish_connection(config)
    end
        
  end
end

ActiveRecord::Base.class_eval do
  include ConnectionNinja
end