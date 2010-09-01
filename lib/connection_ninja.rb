module ConnectionNinja
end

if defined?(::Rails::Railtie)
  require 'connection_ninja/railtie'
end
