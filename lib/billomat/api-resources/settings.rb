module Billomat

  # Class representing a {setting}[http://www.billomat.com/en/api/settings/].
  # As the Billomat API only supports retrieving all settings at once, the only method
  # that should be called on this class is Setting#find (which calls find_single!)
  # TODO: Implement that behaviour, so that the other methods cannot be called accidentally
  #
  # = Example
  #
  #     x = Billomat::Settings.find
  #     x.currency_code # => "EUR"
  #
  class Settings < Base

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

  end

end
