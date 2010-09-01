require 'connection_ninja'

module ConnectionNinja
  class Railtie < Rails::Railtie
    initializer "connection_ninja.active_record" do |app|
      if defined? ::ActiveRecord
        require 'connection_ninja/orms/active_record'
        ActiveRecord::Base.send(:extend, ConnectionNinja::Orms::ActiveRecord)
      end
    end
  end
end
