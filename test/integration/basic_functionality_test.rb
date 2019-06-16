require 'test_helper'

class BasicFunctionalityTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:bob)
  end

  test 'typical user signup' do
    get root_url
    assert_redirected_to signup_path
  end
end
