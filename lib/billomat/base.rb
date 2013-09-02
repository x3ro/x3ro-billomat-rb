require 'nokogiri'

module Billomat

  class Base < ActiveResource::Base
    # Set format to XML because it is the format documented in the Billomat API docs.
    # TODO: Implement possiblity to opt-in to use JSON format
    self.format = :billomat_xml

    class << self

      # This value is set when a collection is fetched via the Billomat API,
      # and will contain all attributes set in the XML root node. This is necessary
      # because the Billomat API stores information on paging in the XML root node,
      # and that information is necessary if one wants to fetch all elements from
      # a certain resource (see http://www.billomat.com/en/api/basics on Billomat API
      # paging). An additional modification necessary for this to work was a custom
      # xml formatter, BillomatXmlFormatter.
      #
      attr_reader :root_attributes

      # TODO: Add the dasherize_xml = false behaviour the Rails3 way
      # http://stackoverflow.com/questions/5438361/use-underscores-instead-of-dashes-with-activeresource-xml-set-dasherize-to-fal
      # ActiveSupport.dasherize_xml = false


      # By overwriting `#interited()` we make sure that every resource class is automatically
      # added to the `resources` array in `Billomat`.
      def inherited(base)
        unless base == Billomat::SingletonBase
          Billomat.resources << base
          base.timeout = 20
        end
        super
      end


      # Overrides the [ActiveResource method](http://api.rubyonrails.org/classes/ActiveResource/Base.html#method-c-collection_path)
      # in order to strip the type extension from the collection path, e.g. `/api/clients`
      # instead of `/api/clients.xml`, as the Billomat API does not support the latter.
      #
      def collection_path(prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end


      # We need to strip the format extension, same as in Base#collection_path
      # @see Base#collection_path
      #
      def element_path(id, prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)

        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{URI.parser.escape id.to_s}#{query_string(query_options)}"
      end


      # Make find_every store the attributes of the root XML node to get Billomat
      # API's paging information. See the "root_attributes" for more info.
      def find_every(options)
        result = super(options)
        xml = Nokogiri::XML(_format.last_decoded)
        @root_attributes = xml.root.attributes()
        result
      end
    end


    def create(*args)
      begin
        super *args
      rescue ActiveResource::ForbiddenAccess => error
        # Check if we got a "Forbidden" because of exceeded plan quota, and throw a more
        # useful exception if that is the case
        #
        if not (error.response.body =~ /insufficient capacity/i).nil?
          raise Billomat::QuotaExceededError.new(error.response, error.message)
        else
          raise error
        end
      end
    end

  end

end
