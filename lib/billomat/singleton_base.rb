module Billomat
  class SingletonBase < Base

    include ResourceWithoutId

    class << self
      def collection_name
        element_name
      end

      def element_path(id,prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end

      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end
    end

    def find
      # TODO: Fetch whether ids where given or not
      # and get the wanted one in those cases
      super(1)
    end

    def self.first
      self.find
    end

    def self.last
      self.find
    end

    alias_method :first, :find
    alias_method :last, :find

    # Prevent collection methods
    def self.all
      raise MethodNotAvailable, "Method not supported on #{self.class.name}"
    end
  end
end
