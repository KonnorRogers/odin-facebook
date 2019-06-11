require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'test@example.com',
                     first_name: 'test', last_name: 'example',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end

  test 'should not validate any emails' do
    assert_no_difference 'User.count' do
      @user.email = ''
      @user.save
    end
  end
end
