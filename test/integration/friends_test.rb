require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
    @marvin = users(:marvin)
    @tabitha = users(:tabitha)
    @bob = users(:bob)
  end

  test 'should return proper friends' do
    # bob should have a pending request with tabitha but not be her friend
    assert_includes @bob.sent_requests, @tabitha
    assert_includes @bob.all_friend_requests_ary, @tabitha
    refute_includes @bob.friends, @tabitha
    refute_includes @bob.all_friends, @tabitha

    # same for tabitha
    assert_includes @tabitha.received_requests, @bob
    assert_includes @tabitha.all_friend_requests_ary, @bob
    refute_includes @tabitha.friends, @bob
    refute_includes @tabitha.all_friends, @bob

    # bob & marvin are friends , but not bob and tabitha
    assert_includes @bob.friends, @marvin
    assert_includes @bob.all_friends, @marvin
    assert_includes @marvin.inverse_friends, @bob
    assert_includes @marvin.all_friends, @bob
    refute_includes @bob.friends, @tabitha
  end

  test 'should display friends properly' do
  end

  test 'adding a friend' do
    sign_in @bob
  end

  test 'removing a friend' do

  end
end
