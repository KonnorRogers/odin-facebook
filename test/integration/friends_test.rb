require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
    @marvin = users(:marvin)
    @tabitha = users(:tabitha)
  end
end
