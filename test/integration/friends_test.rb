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
  end

  test 'adding a friend' do
    sign_in @bob
  end

  test 'removing a friend' do

  end
end
