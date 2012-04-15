require 'test/unit'
require 'billomat-rb'

class BillomatTest < Test::Unit::TestCase
  def test_module_properties
    assert_equal Billomat.account, nil
    assert_equal Billomat.key, nil
    assert_equal Billomat.email, nil
    assert_equal Billomat.password, nil

    x = Billomat.account = "test"
    assert_equal x, "test"
    assert_equal Billomat.account, "test"

    x = Billomat.key = "test"
    assert_equal x, "test"
    assert_equal Billomat.key, "test"

    x = Billomat.authenticate("foo@bar.de", "test")
    assert_equal Billomat.email, "foo@bar.de"
    assert_equal Billomat.password, "test"
    assert_equal Billomat.key, nil # Key is reset when email/password auth is used

    x = Billomat.key = "test"
    assert_equal x, "test"
    assert_equal Billomat.key, "test"
    assert_equal Billomat.email, nil # Email is reset when key-auth is used
    assert_equal Billomat.password, nil # Password is reset when key-auth is used
  end
end

