class TestHelper
  attr_accessor :host, :username, :password
  attr_reader   :path
  
  def initialize
    @host     = "localhost"
    @username = "chris" #Insert username for db here
    @password = ""

    @path = File.expand_path(File.dirname(__FILE__))
  end
  
  def setup_postgresql
    ActiveRecord::Base.establish_connection(
      :adapter  => 'postgresql',
      :database => 'connection_ninja',
      :username => @username,
      :password => @password,
      :host     => @host
    )
    ActiveRecord::Base.logger = Logger.new(File.open("tmp/activerecord.log", "a"))
    
    structure = File.open("spec/fixtures/structure.sql") { |f| f.read.chomp }
    structure.split(';').each { |table|
      ActiveRecord::Base.connection.execute table
    }
    
    10.times do
      Order.create(:ordered_on => 2.weeks.ago)
    end

    10.times do
      Order.create(:ordered_on => 3.weeks.ago, :fulfilled_on => 1.day.ago)
    end
    
    5.times do
      Order.create(:ordered_on => 1.weeks.ago)
    end
      
  end
  
end
