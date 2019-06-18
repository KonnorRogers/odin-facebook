require 'test_helper'

class FriendsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @bob = users(:bob)
    @marvin = users(:marvin)
    @tabitha = users(:tabitha)
  end

  test 'should display friends properly' do
    # bob should have a pending request with tabitha but no be her friend
    assert_includes @bob.pending_friends, @tabitha
    refute_includes @bob.friends, @tabitha

    # same for tabitha
    p @tabitha.pending_friends
    assert_includes @tabitha.pending_friends, @bob
    refute_includes @tabitha.friends, @bob

    # bob & marvin are friends , but not bob and tabitha
    assert_includes @bob.friends, @marvin
    refute_includes @bob.friends, @tabitha
  end
end
