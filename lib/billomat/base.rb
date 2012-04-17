# possibly ResourceWithActiveArchived

module Billomat

  class Base < ActiveResource::Base

    # Set format to XML because it is the format documented in the Billomat API docs.
    # TODO: Implement possiblity to opt-in to use JSON format
    self.format = :xml

    class << self

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


      def element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
      end


      # Overrides the [ActiveResource method](http://api.rubyonrails.org/classes/ActiveResource/Base.html#method-c-collection_path)
      # in order to strip the type extension from the collection path, e.g. `/api/clients`
      # instead of `/api/clients.xml`, as the Billomat API does not support the latter.
      def collection_path(prefix_options = {}, query_options = nil)
        check_prefix_options(prefix_options)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end

    end

  end

end
