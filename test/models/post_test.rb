# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @bob = users(:bob)
  end

  test 'should create a new post' do
    assert_difference 'Post.count', 1 do
      content = 'Hi there, whats up dude'
      @bob.posts.create(content: content)
    end
  end

  test 'should not create a post if length > 140' do

    assert_no_difference 'Post.count' do
      content = 'x' * 141
      @bob.posts.create(content: content)
    end
  end

  test 'should not create a post if content is blank' do
    content = '' * 100
    @bob.posts.create(content: content)
  end

  test 'should show the post fixture after the created post' do
    post1 = posts(:one)
    content = 'hi' * 10
    post2 = @bob.posts.create(content: content)

    posts = Post.all
    assert_equal post2, posts[0]
    assert_equal post1, posts[1]
  end
end
