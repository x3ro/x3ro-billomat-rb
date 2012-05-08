module Billomat::Resources


  # Implements [Billomat Clients](http://www.billomat.com/en/api/clients/)
  #
  class Client < Billomat::Base

    include Billomat::ResourceWithMyselfRecord

    # We override find so that one cannot call it without parameters, as this results
    # in a ActiveResource exception, because, for some reason, when calling #find(),
    # ActiveResource accesses /api/clients, which returns an array of clients, but
    # expects a hash.
    #
    def self.find(*args)
       raise ArgumentError.new("Client.find is not supported without arguments") if args.length < 1
       super
    end


    # Implement access to own user account info as documented on
    # [Billomat Clients API](http://www.billomat.com/en/api/clients/) in the
    # "Your own account info" section.
    #
    # @return [Billomat::Resources::Client]
    #
    def self.myself
      m = find(:myself)
      m.myselfRecord = true
      m
    end

  end

end
