module ConnectionNinja
end

if defined?(::Rails::Railtie)
  class Railtie < Rails::Railtie
    initializer "connection_ninja.active_record" do |app|
      if defined? ::ActiveRecord
        require 'connection_ninja/active_record'
        ActiveRecord::Base.send(:include, ConnectionNinja::ActiveRecord)
      end
    end
  end
end
