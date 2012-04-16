require 'rubygems'
gem 'activeresource', '>=3.2.3'
gem 'activesupport', '>=3.2.3'
require 'active_support'
require 'active_resource'

# A neat ruby library for interacting with the RESTfull API of billomat

module Billomat

  class << self
    attr_accessor :host_format, :domain_format, :protocol, :port, :api_path
    attr_reader :account, :key

    # Sets the account name and updates all resources with the new domain
    def account=(name)
      resources.each do |klass|
        klass.site = klass.site_format % (host_format % [protocol, domain_format % name, ":#{port}", api_path])
      end
      @account = name
    end

    # Sets the api key for all resource
    # Removes all earlier authentication info
    def key=(value)
      resources.each do |klass|
        klass.headers['X-BillomatApiKey'] = value
      end
      @key = value
    end

    # Validates connection
    # returns true when valid false when not
    def validate
      validate! rescue false
    end

    # Same as validate
    # but raises http-error when connection is invalid
    def validate!
      !!Billomat::Myself.find
    end

    def resources
      @resources ||= []
    end


    # Resets the Billomat API to a "clean" state, that is, with no account or key
    # assigned to it.
    #
    # * *Returns* :
    #   - nil
    #
    def reset!
      resources.each do |klass|
        klass.site = nil
        klass.headers.delete 'X-BillomatApiKey'
      end
      @account = nil
      @key = nil
    end

  end

  self.host_format   = '%s://%s%s%s' # protocol :// domain_format port path
  self.domain_format = '%s.billomat.net'
  self.api_path      = '/api'
  self.protocol      = 'http'
  self.port          = '80'

end


"""
TODO: Understand this ActiveSupport monkey-patch and implement the same functionality
for ActiveSupport 3.2.3

module ActiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Hash #:nodoc:
      module Conversions
        def self.included(klass)
          klass.extend(ClassMethods)
        end

        module ClassMethods

          private

          # Dirty monkey patching indeed
          def typecast_xml_value_with_array_fix(value)
            value.delete('total')
            value.delete('type')
            value.delete('per_page')
            value.delete('page')
            typecast_xml_value_without_array_fix(value)
          end

          alias_method_chain :typecast_xml_value, :array_fix
        end
      end
    end
  end
end
"""


require File.dirname(__FILE__) + '/billomat/exceptions'
require File.dirname(__FILE__) + '/billomat/resource_types'
require File.dirname(__FILE__) + '/billomat/base'
require File.dirname(__FILE__) + '/billomat/singleton_base'
require File.dirname(__FILE__) + '/billomat/read_only_singleton_base'

require File.dirname(__FILE__) + '/billomat/api-resources/settings'
require File.dirname(__FILE__) + '/billomat/api-resources/users'
require File.dirname(__FILE__) + '/billomat/api-resources/myself'
require File.dirname(__FILE__) + '/billomat/api-resources/clients'
require File.dirname(__FILE__) + '/billomat/api-resources/unit'
