module Billomat::Resources

  # Implements [Billomat Articles](http://www.billomat.com/en/api/users/)
  #
  class User < Billomat::Base
    include Billomat::ResourceWithoutWriteAccess
  end

end
