require 'test_helper'

class UserUnitsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_units_create_url
    assert_response :success
  end

end
