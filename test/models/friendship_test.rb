require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @bob = users(:bob)
    @tabitha = users(:tabitha)
    @marvin = users(:marvin)
  end

  test 'should return proper friends' do
    # bob should have a pending request with tabitha but not be her friend
    assert_includes @bob.sent_requests, @tabitha
    refute_includes @bob.friends, @tabitha

    # same for tabitha
    assert_includes @tabitha.received_requests, @bob
    refute_includes @tabitha.friends, @bob

    # bob & marvin are friends , but not bob and tabitha
    assert_includes @bob.friends, @marvin
    assert_includes @marvin.inverse_friends, @bob
    refute_includes @bob.friends, @tabitha
  end

  test 'should not validate friendship' do

  end
end
