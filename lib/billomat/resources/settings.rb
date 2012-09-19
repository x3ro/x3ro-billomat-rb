module Billomat::Resources

=begin
Class representing a [Setting](http://www.billomat.com/en/api/settings/).
As the Billomat API only supports retrieving all settings at once, the only method
that should be called on this class is Setting#find (which calls find_single!)

* TODO: Implement that behaviour, so that the other methods cannot be called accidentally


# Example

The Billomat API currently only supports retrieving all settings at once:

    settings = Billomat.res(:settings).find
    settings.currency_code # => "USD"

Modifying settings is also supported:

    x = Billomat.res(:settings).find
    x.currency_code = "USD"
    x.save # => true

=end
  class Settings < Billomat::Base

    self.schema do
      string :invoice_intro
      string :invoice_note
      string :offer_intro
      string :offer_note
      string :invoice_email_subject
      string :invoice_email_body
      string :offer_email_subject
      string :offer_email_body
      string :article_number_pre
      string :client_number_pre
      string :invoice_number_pre
      string :offer_number_pre

      integer :offer_number_length
      integer :invoice_number_length
      integer :article_number_length
      integer :client_number_length

      string :currency_code

      float :discount_rate
      integer :discount_days
      integer :due_days
      integer :offer_validity_days
    end


    def self.find(*args)
      raise ArgumentError.new("Settings#find does not support any options") if args.length > 0
      find_single(nil, {})
    end

  end

end
