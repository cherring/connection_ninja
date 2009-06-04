class Order < ActiveRecord::Base
  
end

class Customer < ActiveRecord::Base
  use_connection_ninja(:alternate)
end