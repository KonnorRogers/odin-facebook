require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:bob)
    @post = posts(:one)
  end

  test 'should add a comment to the post' do
    content = 'this is my first comment'

    assert_difference 'Comment.count', 1 do
      @post.comments.create(user: @user, content: content)
    end
  end

  test 'should not add a comment to the post > 140 characters' do
    assert_no_difference 'Comment.count' do
      content = 'h' * 141
      @post.comments.create(user: @user, content: content)
    end
  end

  test 'should not add a blank comment to the post' do
    assert_no_difference 'Comment.count' do
      content = 'h' * 141
      @post.comments.create(user: @user, content: content)
    end
  end
end
