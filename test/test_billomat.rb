require 'test/unit'
require 'billomat-rb'

class BillomatTest < Test::Unit::TestCase

  def setup
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

end

