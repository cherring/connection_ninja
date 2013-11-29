require 'active_record'
require 'connection_ninja'

module ConnectionNinja
  module Orms
    module ActiveRecord
      def use_connection_ninja(config_group)
          establish_connection ninja_config(config_group)
      end

      protected
      def ninja_config(config_group)
        begin
          configurations[config_group.to_s][::Rails.env]
        rescue
          raise ::ActiveRecord::AdapterNotFound, "connection ninja could not find the #{::Rails.env} configuration for group \"#{config_group.to_s}\""
        end
      end
    end
  end
end
