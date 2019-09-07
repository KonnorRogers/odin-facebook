require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'test@example.com',
                     first_name: 'testing',
                     last_name: 'example',
                     password: 'foobar',
                     password_confirmation: 'foobar',
                     birthday: Date.today - 20.years,
                     gender: 'male'
                    )
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

  # test 'should not valid any names' do
  #   assert_no_difference 'User.count' do
  #     @user.first_name = ' ' * 5
  #     @user.save
  #   end

  #   assert_no_difference 'User.count' do
  #     @user.first_name = '!konnor'
  #     @user.save
  #   end

  #   assert_no_difference 'User.count' do
  #     @user.last_name = '1test'
  #     @user.save
  #   end
  # end


  # test 'should not validate any birthdays where age < 13 or > 120' do
  #   assert_no_difference 'User.count' do
  #     # 12 years old and 364 days
  #     @user.birthday = Date.today - 13.years + 1.day
  #     @user.save
  #   end

  #   assert_no_difference 'User.count' do
  #     # 121 years old and 1 day
  #     @user.birthday = Date.today - 120.years - 1.day
  #     @user.save
  #   end
  # end

  # test 'should validate a user with spaces in their name' do
  #   assert_difference 'User.count', 1 do
  #     @user.first_name = 'hi there paul'
  #     @user.last_name = 'sup doc'
  #     @user.save
  #   end
  # end
end
