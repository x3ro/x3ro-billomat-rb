module Billomat::Resources

=begin
Implements [Billomat Articles](http://www.billomat.com/en/api/invoices/)


# Example

An invoice needs to have the `client_id` field set, e.g.

    client = Billomat.res(:client).first

    invoice = Billomat.res(:invoice).new
    invoice.client_id = client.id
    invoice.save

=end
  class Invoice < Billomat::Base
  end

end



