module Billomat::Resources

  # Implements [Billomat Estimate](http://www.billomat.com/en/api/estimates/)
  #
  # The API documentation wording (estimate) and the URL resource name (offer)
  # differ, so I chose to use the name from the URL because that way I don't have
  # to alter the ActiveResource magic.
  #
  class Offer < Billomat::Base
  end

end
