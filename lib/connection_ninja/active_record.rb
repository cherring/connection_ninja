require 'active_record'
require 'connection_ninja'

module ConnectionNinja
  module ActiveRecord
    def use_connection_ninja(config_name)
      connect_to_db(config(config_name))
    end
    
    def config(config)
      ActiveRecord::Base.configurations["#{config.to_s}_#{Rails.env}"]
    end
      
    def connect_to_db(config)
      establish_connection(config)
    end
  end
end
