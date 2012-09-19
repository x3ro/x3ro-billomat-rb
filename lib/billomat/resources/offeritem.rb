module Billomat::Resources

=begin
Implements [Billomat Offer Items](http://www.billomat.com/en/api/estimates/items/). An
offer's items can be retrieved like so:

    offer = Billomat.res(:offer).first
    offer_items = Billomat.res(:offer_item).for_offer(offer.id)

Knowing the unique ID of the offer item itself, the following is also possible:

    offer_item_id = 12345
    offer_item = Billomat.res(:offer_item).find(offer_item_id)

=end
  class OfferItem < Billomat::Base
    self.element_name = 'offer-item'

    def self.for_offer(offer_id)
      find(:all, :params => {:offer_id => offer_id})
    end

  end

end
