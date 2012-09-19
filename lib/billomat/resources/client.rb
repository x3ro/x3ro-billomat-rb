module Billomat::Resources


  # Implements [Billomat Clients](http://www.billomat.com/en/api/clients/)
  #
  class Client < Billomat::Base

    include Billomat::ResourceWithMyselfRecord
    extend Billomat::ResourceWithMyselfRecordStatic

    # We override find so that one cannot call it without parameters, as this results
    # in a ActiveResource exception, because, for some reason, when calling #find(),
    # ActiveResource accesses /api/clients, which returns an array of clients, but
    # expects a hash.
    #
    def self.find(*args)
       raise ArgumentError.new("Client.find is not supported without arguments") if args.length < 1
       super
    end




  end

end
