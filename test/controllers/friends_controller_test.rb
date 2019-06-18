require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
  end

  test "should get index" do
    sign_in @bob
    get friends_url
    assert_response :success
  end
end
