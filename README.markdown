Introduction
============

Connection Ninja is a really simple gem to help connection to multiple databases. I wrote it to help with the way we were connected a new application at work to our older application that holds the data we needed to do reporting on. We have code (models) that is shared between those two applications, and I wanted them to be able to connect to the correct database regardless which app they were in, and therefore which database.yml they were reading.

Installation
============

Due to hopefully everyone upgrading to rails 3, if you need to use this with Rails 2.x just install the old version.

Rails 3
=======

    gem install connection_ninja
    
Rails 3 Configuration
=====================

    class MyModel < ActiveRecord::Base
      use_connection_ninja(:other_database)
    end

After your normal configuration in database.yml add a new group:

    other_database:
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

Rails 2.x
=========

    gem install connection_ninja -v 0.3.5

Rails 2.x Configuration
=====================

    class MyModel < ActiveRecord::Base
      use_connection_ninja(:other_database)
    end

After your normal configuration in database.yml add a new group:

    other_database_development:
      adapter: postgresql
      database: database_name
      user: username

    other_database_test:
      adapter: postgresql
      database: database_name
      user: username

    other_database_production:
      adapter: postgresql
      database: database_name
      user: username

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
