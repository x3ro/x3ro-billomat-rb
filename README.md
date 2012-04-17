# billomat-rb

A neat ruby library for interacting with the [RESTful API](http://www.billomat.com/api/) of [Billomat](http://www.billomat.com/)


# Requirements

billomat-rb requires `active_resource` and `active_support` in version 3.2.3 or above.


# Simple usage example

    require 'billomat-rb'
    
    Billomat.account = "myapitest"
    Billomat.key = "<insert your api key here>"

    puts Billomat.validate! # Should return true at this point


# Notes

Documentation is generated using

    rake yard # or
    yard doc


# Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.


# Copyright

Copyright (c) 2010 Ronald Becher. See LICENSE for details.
