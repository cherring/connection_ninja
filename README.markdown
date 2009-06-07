Introduction
============

Connection Ninja is a really simple gem to help connection to multiple databases. I wrote it to help with the way we were connected a new application at work to our older application that holds the data we needed to do reporting on. We have code (models) that is shared between those two applications, and I wanted them to be able to connect to the correct database regardless which app they were in, and therefore which database.yml they were reading.

Configuration
=============

  class MyModel < ActiveRecord::Base
    use_connection_ninja(:database)
  end

Then in your after your normal configuration in database.yml:

  database_development:
    adapter: postgresql
    database: database_name
    user: username

  database_test:
    adapter: postgresql
    database: database_name
    user: username

  database_production:
    adapter: postgresql
    database: database_name
    user: username

Connection ninja takes the database name you pass in and appends the environment on the end so it is important that you name the entries in database.yml as "#{database}_#{RAILS_ENV}" or it won't work.

WHY?
===

If you look at the code you will probably wonder why I didn't just call establish_connection "database_#{RAILS_ENV}", well at first I went about it differently, and thought I needed it. Now I realised maybe I don't, but it was a great exercise in learning how to write a gem and I learned a few things about ActiveRecord along the way which was great. It also gave me IMO a nice clean way to connect a bunch of models to the right database regardless of which of my apps the code was sitting in.

How I used it
=============

To get my 20 or 30 models to all use one connection I used a simple abstract class to do it. I also got to learn about these along the way

  class OtherConnection < ActiveRecord::Base
    self.abstract_class = true
    use_connection_ninja(:database)
  end

So I could:

  class ModelFromOtherDB < OtherConnection

  end