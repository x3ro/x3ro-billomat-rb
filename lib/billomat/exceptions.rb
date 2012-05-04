module Billomat
  class MethodNotAvailable < StandardError; end
  class NotInitializedError < StandardError; end
  class QuotaExceededError < ActiveResource::ForbiddenAccess; end
end
