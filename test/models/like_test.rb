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

  test 'should not add a second like to the post' do
    @post.likes.create(user: @user)
    assert_no_difference 'Like.count' do
      @post.likes.create(user: @users)
    end
  end

  test 'adds the like if the user unlikes the object' do
    assert_difference 'Like.count', 1 do
      @post.likes.create(user: @user)
    end

    assert_difference 'Like.count', 1 do
      @post.likes.destroy(user: @user)
    end
  end
end
