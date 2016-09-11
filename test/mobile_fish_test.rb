require 'test_helper'

class MobileFishTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MobileFish::VERSION
  end
end
