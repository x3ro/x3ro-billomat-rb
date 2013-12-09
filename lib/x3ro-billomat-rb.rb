require 'rubygems'
gem 'activeresource', '>=3.2.3'
gem 'activesupport', '>=3.2.3'
require 'active_support'
require 'active_resource'
require 'active_resource/exceptions'

=begin
A Ruby library for interacting with the RESTful Billomat API



# Initializing

To initialize the Billomat API, you need your account name and an API key. Information
on how this key can be obtain can be found [here](http://www.billomat.com/en/api/basics/),
in the **Authentication** section.

    require 'billomat-rb'

    Billomat.account = "<insert your account name here>"
    Billomat.key = "<insert your api key here>"

    puts Billomat.validate! # Should return true at this point



# Caveats

* `Billomat.res(:some_resource).delete(record_id)` is currently broken because of a
    [a bug in ActiveResource](https://github.com/rails/activeresource/issues/26). Use
    `destroy` on the record instance instead.

* The API naming differs on [estimates vs. offers](http://www.billomat.com/en/api/estimates/).
  I decided to use `Offer` as the resource name for what is documented as `Estimate` in
  the API docs, because it is actually being accessed as `/api/offers`.



# Note on IDs

The record IDs retrieving from the Billomat API are globally unique identifiers,
that is, they do not start at `1` for your account. Therefore, **the following will
probably fail** for you:

    Billomat.res(:client).find(1)



# This is NOT an API documentation!

If you don't know the API itself, please take a look at
[the official API docs](http://www.billomat.com/en/api/), I'm just trying to give
you a few examples on how to use this gem :)



# Resources

All examples within the documentation assume you have initialized the API properly.


## Basic resource access

The following resources **do not** work this way, and have separate usage examples:

* Settings
* Invoices (only because of mandatory field `client_id`)

Every other resource provided by this API can be accessed using the techniques depicted
in the following examples. Additional examples may be found in the class documentation of
of the particular resource.

### Retrieving all clients

    Billomat.res(:client).all

### Retrieving a client with a known id (see the note on IDs)

    Billomat.res(:client).find(123456)

### Searching for a client with a certain name:

    Billomat.res(:client).find(:all, :params => { :name => "google" })


## Getting information about the user accessing the API

Information on identifying the user with whose credentials the API is being accessed,
you can take a look at {Billomat::ResourceWithMyselfRecord}.



# Currently implemented API resources

* {Billomat::Resources::Article}
* {Billomat::Resources::Client}
* {Billomat::Resources::Invoice}
* {Billomat::Resources::Myself}
* {Billomat::Resources::Offer}
* {Billomat::Resources::OfferItem}
* {Billomat::Resources::Settings}
* {Billomat::Resources::Unit}
* {Billomat::Resources::User}

=end
module Billomat

  class << self
    attr_writer :resources

    # Contains an array of loaded resource classes (sub-classes of
    # ActiveResource::Base) that implement Billomat API methods. Shouldn't be
    # accessed directly as it is only necessary for internal use.
    # @return [Array]
    #
    def resources
      @resources ||= []
    end


    # Updating the Billomat account name updates all loaded resources with the
    # respective new API URL (there is a API subdomain for every account
    # ([read more](http://www.billomat.com/en/api/basics/)).
    #
    attr_reader :account

    # See `attr_reader :account`
    def account=(name)
      resources.each do |klass|
        klass.site = @host_format % [@protocol, @domain_format % name, ":#{@port}", @api_path]
      end
      @account = name
    end


    # Holds the API authentication key. Updating this attribute will remove previously
    # set authentication information.
    # @return [String]
    #
    attr_reader :key

    # Sets the api key for all resource
    # Removes all earlier authentication info
    def key=(value)
      resources.each do |klass|
        klass.headers['X-BillomatApiKey'] = value
      end
      @key = value
    end


    # Tries to connect to the Billomat API
    # @return [bool] True if the connection attempt was successful, otherwise false
    # @raise [Exception] May raise an exception if an error occurred
    def validate!
      !!Billomat.res(:user).myself
    end


    # Resets the Billomat API to a "clean" state, that is, with no account or key
    # assigned to it.
    #
    # @return [void]
    #
    def reset!
      resources.each do |klass|
        klass.site = nil
        klass.headers.delete 'X-BillomatApiKey'
      end
      @account = nil
      @key = nil
    end


    # Fetches an available API resource class, previously checking if the Billomat class
    # has been initialized and is ready to be used (because if uninitialized, API calls
    # result in difficult-to-debug error messages. Therefore it is recommended to use this
    # method instead of accessing the resources directly).
    #
    # @return [Billomat::Base]
    #
    def res(resource)
      raise NotInitializedError.new("Billomat account or key was not set!") if @account.nil? or @key.nil?

      resource = resource.to_s.split('_').map { |x| x.capitalize }.join('').to_sym
      raise ArgumentError.new("Unknown resource type '#{resource}'") if not Billomat::Resources.constants.include? resource

      Billomat::Resources.const_get(resource)
    end


  end

  @host_format   = '%s://%s%s%s' # protocol :// domain_format port path
  @domain_format = '%s.billomat.net'
  @api_path      = '/api'
  @protocol      = 'http'
  @port          = '80'

end



require File.dirname(__FILE__) + '/billomat/billomat_xml_format'
require File.dirname(__FILE__) + '/billomat/exceptions'
require File.dirname(__FILE__) + '/billomat/resource_types'
require File.dirname(__FILE__) + '/billomat/base'
require File.dirname(__FILE__) + '/billomat/singleton_base'
require File.dirname(__FILE__) + '/billomat/read_only_singleton_base'

require File.dirname(__FILE__) + '/billomat/resources/settings'
require File.dirname(__FILE__) + '/billomat/resources/user'
require File.dirname(__FILE__) + '/billomat/resources/client'
require File.dirname(__FILE__) + '/billomat/resources/unit'
require File.dirname(__FILE__) + '/billomat/resources/article'
require File.dirname(__FILE__) + '/billomat/resources/invoice'
require File.dirname(__FILE__) + '/billomat/resources/invoice_payment'
require File.dirname(__FILE__) + '/billomat/resources/offer'
require File.dirname(__FILE__) + '/billomat/resources/offeritem'
require File.dirname(__FILE__) + '/billomat/resources/creditnote'
