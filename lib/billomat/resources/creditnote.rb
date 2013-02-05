module Billomat::Resources

=begin
Implements [Billomat Credit Notes](http://www.billomat.com/en/api/credit-notes). A
credit note can be retrieved like so:

    credit_note = Billomat.res(:credit_note).find(credit_note_id)

=end
  class CreditNote < Billomat::Base
    self.element_name = 'credit-note'

    #def self.for_offer(offer_id)
    #  find(:all, :params => {:offer_id => offer_id})
    #end

  end

end
