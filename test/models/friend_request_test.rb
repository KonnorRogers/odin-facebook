require 'test_helper'

class FriendRequestTest < ActiveSupport::TestCase
  def setup
    @bob = users(:bob)
    @new_user = User.create(
      first_name: 'new',
      last_name: 'user',
      password: Devise::Encryptor.digest(User, 'foobar'),
      email: 'new@railsexample.com',
      gender: 'male',
      birthday: Date.today - 30.years
    )
  end

  test 'should create a friend request' do
    assert_difference 'FriendRequest.count', 1 do
      new = @bob.create_friend_request(@new_user.id)

      if new.save
      else
        p new.errors
      end
      # @bob.friend_requests.build(friend_id: @new_user.id).save
    end
  end

  test 'should not create friend request if the friend is self' do
    assert_no_difference 'FriendRequest.count' do
      @bob.friend_requests.build(friend_id: @bob.id).save
      @bob.create_friend_request(@bob.id).save
    end
  end
end
