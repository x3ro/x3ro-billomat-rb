class ReadOnlySingletonBase < SingletonBase
  include ResourceWithoutWriteAccess
end
