require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:marvin)
    @post = posts(:one)
  end

  test 'should add a like to the post' do
    assert_difference 'Like.count', 1 do
      @post.likes.create(user: @user)
    end
  end
end
