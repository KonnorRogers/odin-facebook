require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = {
      first_name: 'spider',
      last_name: 'monkey',
      email: 'spidermonkey@example.com',
      password: 'foobar',
      password_confirmation: 'foobar',
      gender: 'other',
      birthday: Date.today - 15.years
    }
  end

  test 'typical user signup' do
    get root_url
    assert_redirected_to signup_path

    assert_difference 'User.count', 1 do
      post signup_path, params: { user:  @user }
    end
  end

  test 'invalid user signups' do
  end
end
