require 'test/unit'
require 'billomat-rb'


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
      assert x.is_a? Array

      x = Billomat.res(resource).first
      assert x.is_a? Billomat.res(resource)

      x = Billomat.res(resource).last
      assert x.is_a? Billomat.res(resource)
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
      assert_equal(Billomat::Resources.const_get(klass), Billomat.res(klass), "Billomat#res seems to be broken")
    end
  end



  # Test client resource

  def test_read_client_resource
    x = Billomat.res(:client).find(:all)
    assert x.is_a? Array
  end


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


  def test_create_client_resource
    x = Billomat.res(:client).new
    assert x.save, "Could not save newly created client"
    assert x.save, "Client creation resulted in invalid client record"
    assert(x.id > 0, "New client was not successfully created (no id)")

    y = Billomat.res(:client).find(x.id)
    y.email = "foo@bar.de"
    assert y.save, "Editing client resource did not succeed"

    z = Billomat.res(:client).find(x.id)
    assert_equal "foo@bar.de", z.email
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

end

