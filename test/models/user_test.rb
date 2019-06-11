require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'test@example.com',
                     first_name: 'testing',
                     last_name: 'example',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  test 'should not validate any emails' do
    assert_no_difference 'User.count' do
      @user.email = ''
      @user.save
    end

    assert_no_difference 'User.count' do
      @user.email = 'xyzy@@gmail.com'
      @user.save
    end

    assert_no_difference 'User.count' do
      @user.email = ' ' * 5
      @user.save
    end
  end

  test 'should not valid any names' do
    assert_no_difference 'User.count' do
      @user.first_name = ' ' * 5
      @user.save
    end

    assert_no_difference 'User.count' do
      @user.first_name = '!konnor'
      @user.save
    end

    assert_no_difference 'User.count' do
      @user.last_name = '1test'
      @user.save
    end
  end
end
