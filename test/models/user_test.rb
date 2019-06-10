require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email: 'test@example.com',
                     first_name: 'test', last_name: 'example',
                     password: 'foobar',
                     password_confirmation: 'foobar')
  end
end
