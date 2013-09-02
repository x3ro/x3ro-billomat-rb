# This formatter is necessary so that we can retrieve the root node attributes
# from an XML API request, to get paging information.
# See Billomat::Base.root_attributes for more information.
module ActiveResource
  module Formats
    module BillomatXmlFormat
      extend ActiveResource::Formats::XmlFormat
      extend self

      attr_reader :last_decoded

      def decode(xml)
        @last_decoded = xml
        super(xml)
      end
    end
  end
end
