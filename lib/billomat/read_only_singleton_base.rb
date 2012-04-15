module Billomat
  class ReadOnlySingletonBase < SingletonBase
    include ResourceWithoutWriteAccess
  end
end
