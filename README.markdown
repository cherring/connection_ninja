Introduction
============

Connection Ninja is a really simple gem to help connection to multiple databases. I wrote it to help with the way we were connected a new application at work to our older application that holds the data we needed to do reporting on. We have code (models) that is shared between those two applications, and I wanted them to be able to connect to the correct database regardless which app they were in, and therefore which database.yml they were reading.

Installation
============

To install connection_ninja you need to be using gemcutter, so install it if you haven't:

    gem install connection_ninja
    
Configuration
=============

    class MyModel < ActiveRecord::Base
      use_connection_ninja(:database)
    end

Then in your after your normal configuration in database.yml add a new group:

    database:
      development:
        adapter: postgresql
        database: database_name
        user: username

      test:
        adapter: postgresql
        database: database_name
        user: username

      production:
        adapter: postgresql
        database: database_name
        user: username

Connection ninja takes the database name you pass in and appends the environment on the end so it is important that you name the entries in database.yml as "#{database}_#{RAILS_ENV}" or it won't work.

WHY?
===

Pure laziness. Rather than putting together a hash you can just call a group with use_connection_ninja(:group)

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
