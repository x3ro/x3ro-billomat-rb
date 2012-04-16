require 'test/unit'
require 'billomat-rb'

class BillomatTest < Test::Unit::TestCase
  def test_module_properties
    assert_equal Billomat.account, nil
    assert_equal Billomat.key, nil

    x = Billomat.account = "test"
    assert_equal x, "test"
    assert_equal Billomat.account, "test"

    x = Billomat.key = "test"
    assert_equal x, "test"
    assert_equal Billomat.key, "test"
  end
end

