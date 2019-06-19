require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
    @marvin = users(:marvin)
    @tabitha = users(:tabitha)
    @bob = users(:bob)
  end

  test 'should display friends properly' do
    # bob should have a pending request with tabitha but not be her friend
    assert_includes @bob.pending_friends, @tabitha
    refute_includes @bob.friends, @tabitha

    # same for tabitha
    assert_includes @tabitha.pending_requests, @bob
    refute_includes @tabitha.friends, @bob

    # bob & marvin are friends , but not bob and tabitha
    assert_includes @bob.friends, @marvin
    assert_includes @marvin.inverse_friends, @bob
    refute_includes @bob.friends, @tabitha
  end

  test 'adding a friend' do
    sign_in @bob
  end

  test 'removing a friend' do

  end
end
