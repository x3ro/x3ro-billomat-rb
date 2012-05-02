module Billomat::Resources

  class Users < Billomat::Base
    include Billomat::ResourceWithoutWriteAccess
  end

end
