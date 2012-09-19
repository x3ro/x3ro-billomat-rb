module Billomat::Resources

  # Implements [Billomat Articles](http://www.billomat.com/en/api/users/)
  #
  class User < Billomat::Base
    include Billomat::ResourceWithMyselfRecord
    extend Billomat::ResourceWithMyselfRecordStatic

    include Billomat::ResourceWithoutWriteAccess
  end

end
