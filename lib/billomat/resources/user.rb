module Billomat::Resources

  class User < Billomat::Base
    include Billomat::ResourceWithoutWriteAccess
  end

end
