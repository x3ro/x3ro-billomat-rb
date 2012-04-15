# possibly ResourceWithActiveArchived

module Billomat

  class Base < ActiveResource::Base
    class << self

      # TODO: Add the dasherize_xml = false behaviour the Rails3 way
      # http://stackoverflow.com/questions/5438361/use-underscores-instead-of-dashes-with-activeresource-xml-set-dasherize-to-fal
      # ActiveSupport.dasherize_xml = false
      def inherited(base)
        unless base == Billomat::SingletonBase
          Billomat.resources << base
          class << base
            attr_accessor :site_format
          end
          base.site_format = '%s'
          base.timeout = 20
        end
        super
      end

      def element_path(id, prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
      end

      def el_p(id,prefix_options = {}, query_options = nil)
        element_path(id,prefix_options, query_options)
      end

      def coll_p(prefix_options = {}, query_options = nil)
        collection_path(prefix_options, query_options)
      end



      def collection_path(prefix_options = {}, query_options = nil)
        prefix_options, query_options = split_options(prefix_options) if query_options.nil?
        "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
      end

      # Some common shortcuts from ActiveRecord

      def all(options={})
        find(:all,options)
      end

      def first(options={})
        find_every(options).first
      end

      def last(options={})
        find_every(options).last
      end
    end

    private

    def query_string?(options)
      options.is_a?(String) ? "#{options}" : super
    end
  end

end
