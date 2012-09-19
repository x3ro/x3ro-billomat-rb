require 'simplecov'
SimpleCov.start
require 'test/unit'
require 'billomat-rb'
require 'turn/autorun'


puts "!!! Running these tests will MODIFY the account settings of the given account !!!"
puts "Do you want to continue? (yes/no)"
abort("Bye!") if $stdin.gets != "yes\n"


class BillomatTest < Test::Unit::TestCase

  # This method creates a basic functionality test for a given resource.
  # The following things are tested:
  #
  #   * Is the resource readable, that is, can we access records from it
  #   * Can we create new records of this resource
  #   * Can we edit a certain field in this resource
  #
  def self.default_resource_test(resource, test_field, test_value)
    # Default test for reading a resource
    define_method "test_read_#{resource}_resource".to_sym do
      x = Billomat.res(resource).find(:all)
      assert x.is_a?(Array), "find(:all) seems to have failed, result is not an array"
    end

    # Default test for creating a resource
    define_method "test_create_#{resource}_resource".to_sym do
      x = Billomat.res(resource).new
      assert x.save, "Could not save newly created #{resource}"
      assert x.save, "#{resource} creation resulted in invalid #{resource} record"
      assert(x.id > 0, "New #{resource} was not successfully created (no id)")

      y = Billomat.res(resource).find(x.id)
      y.attributes[test_field] = test_value
      assert y.save, "Editing #{resource} resource did not succeed"

      z = Billomat.res(resource).find(x.id)
      assert_equal test_value, z.attributes[test_field]

      # Test resource deletion
      x.destroy
      assert_raise ActiveResource::ResourceNotFound do
        Billomat.res(resource).find(x.id)
      end
    end

  end



  #
  # Prepare the tests
  #

  def setup
    # Make sure API credentials for the unit tests are supplied
    if ENV['ACC'].nil? or ENV['KEY'].nil?
      abort("\n\n Please call using 'KEY={billomatApiKey} ACC={billomatAccount} rake test'\n\n")
    end

    # The API Key and the account used when running the unit tests has to be passed
    # using environment variables as Rake apparently does not support passing parameters
    # to the test-task, and I don't want API credentials to end up in this test file
    # Run tests using ACC={account} KEY={key} rake test
    @apiKey = ENV['KEY']
    @account = ENV['ACC']

    Billomat.account = @account
    Billomat.key = @apiKey
  end


  def teardown
    Billomat.reset!
  end



  #
  # Let the tests begin!
  #



  # Test API connectivity and basic functionality

  def test_billomat_connectivity
    assert Billomat.validate!, "Testing if we're able to connect to Billomat using the supplied API credentials"
  end


  def test_module_api_properties
    Billomat.reset!

    assert_equal nil, Billomat.account
    assert_equal nil, Billomat.key

    x = Billomat.account = @account
    assert_equal @account, x
    assert_equal @account, Billomat.account

    x = Billomat.key = @apiKey
    assert_equal @apiKey, x
    assert_equal @apiKey, Billomat.key
  end


  def test_api_resource_getter
    Billomat::Resources.constants.each do |klass|
      resource = klass.to_s.scan(/[A-Z][^A-Z]*/).map { |x| x.downcase }.join('_').to_sym
      assert_equal(Billomat::Resources.const_get(klass), Billomat.res(resource), "Billomat#res seems to be broken")
    end
  end



  # Test client resource

  default_resource_test :client, :email, "foo@bar.de"


  def test_read_client_resource_myself
    x = Billomat.res(:client).myself
    assert x.is_a?(Billomat::Resources::Client), "Could not retrieve own user account"
    assert x.id > 0, "Could not retrieve own user account"
  end


  def test_save_client_resource_myself
    x = Billomat.res(:client).myself
    assert x.isMyselfRecord?, "Marking MyselfRecord did not succeed"

    assert_raise NoMethodError do
      x.save
    end

    assert_raise NoMethodError do
      x.destroy
    end
  end


  # Test settings resource

  def test_read_setting_resource
    x = Billomat.res(:settings).find
    assert x.is_a? Billomat.res(:settings)
  end


  def test_write_setting_resource
    x = Billomat.res(:settings).find
    old = x.offer_number_length
    x.offer_number_length += 1
    x.save

    y = Billomat.res(:settings).find
    assert_equal old+1, y.offer_number_length
  end



  # Test article resource

  default_resource_test :article, :description, "test1234"



  # Test unit resource

  default_resource_test :unit, :name, "foobar"



  # Test invoice resource

  default_resource_test :invoice, :label, "a nice label"

  # We need to overwrite the default create test because an invoice needs a client id
  # as a mandatory parameter
  #
  def test_create_invoice_resource
    resource = :invoice
    test_field = :label
    test_value = "a nice label"

    # We need a client so that we can assign a valid client id to the invoice
    # It is deleted in test_delete_invoice_resource
    client = Billomat.res(:client).new
    client.save

    x = Billomat.res(resource).new
    x.client_id = client.id
    assert x.save, "Could not save newly created #{resource}"
    assert x.save, "#{resource} creation resulted in invalid #{resource} record"
    assert(x.id > 0, "New #{resource} was not successfully created (no id)")


    y = Billomat.res(resource).find(x.id)
    y.attributes[test_field] = test_value
    assert y.save, "Editing #{resource} resource did not succeed"

    z = Billomat.res(resource).find(x.id)
    assert_equal test_value, z.attributes[test_field]
  end

  # We need to overwrite the default test here was well, because the client created
  # in `test_create_invoice_resource` needs to be cleaned up.
  #
  def test_delete_invoice_resource
    resource = :invoice

    x = Billomat.res(resource).last
    id = x.id

    client_id = x.client_id

    x.destroy

    assert_raise ActiveResource::ResourceNotFound do
      Billomat.res(resource).find(id)
    end

    # Clean up the client created in test_create_invoice_resource
    Billomat.res(:client).find(client_id).destroy
  end



  # Test user resource

  def test_read_user_resource
    x = Billomat.res(:user).find(:all)
    assert x.is_a?(Array), "find(:all) seems to have failed, result is not an array"
  end

  def test_user_resource_readonly
    user = Billomat.res(:user).first

    assert_raise NoMethodError do
      Billomat.res(:user).new.save
    end

    assert_raise NoMethodError do
      user.email = "foo@bar.de"
      user.save
    end

    assert_raise NoMethodError do
      user.destroy
    end
  end



  # Test offer resource

  default_resource_test :offer, :label, "a nice label"

  # We need to overwrite the default create test because an offer needs a client id
  # as a mandatory parameter
  #
  def test_create_offer_resource
    resource = :offer
    test_field = :label
    test_value = "a nice label"

    # We need a client so that we can assign a valid client id to the offer
    # It is deleted in test_delete_invoice_resource
    client = Billomat.res(:client).new
    client.save

    x = Billomat.res(resource).new
    x.client_id = client.id
    assert x.save, "Could not save newly created #{resource}"
    assert x.save, "#{resource} creation resulted in invalid #{resource} record"
    assert(x.id > 0, "New #{resource} was not successfully created (no id)")


    y = Billomat.res(resource).find(x.id)
    y.attributes[test_field] = test_value
    assert y.save, "Editing #{resource} resource did not succeed"

    z = Billomat.res(resource).find(x.id)
    assert_equal test_value, z.attributes[test_field]
  end

  # We need to overwrite the default test here was well, because the client created
  # in `test_create_offer_resource` needs to be cleaned up.
  #
  def test_delete_invoice_resource
    resource = :offer

    x = Billomat.res(resource).last
    id = x.id

    client_id = x.client_id

    x.destroy

    assert_raise ActiveResource::ResourceNotFound do
      Billomat.res(resource).find(id)
    end

    # Clean up the client created in test_create_invoice_resource
    Billomat.res(:client).find(client_id).destroy
  end



end

