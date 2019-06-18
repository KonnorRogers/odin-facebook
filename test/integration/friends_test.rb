require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
    @marvin = users(:marvin)
    @tabitha = users(:tabitha)
  end

  test 'should list tabitha as a pending friend' do
    friend_requests = @bob.pending_friends
    assert_includes friend_requests, @tabitha
    refute_includes friend_requests, @marvin

    friends = @bob.friends
    assert_includes friends, @marvin
    refute_includes friends, @tabitha
  end
end
