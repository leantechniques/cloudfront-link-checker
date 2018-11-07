require 'minitest/autorun'
require 'cloudfront_link_checker'

class CloudfrontLinkCheckerTest < Minitest::Test
  def test_setup
    assert_equal 5, CloudfrontLinkChecker.method
  end
end
