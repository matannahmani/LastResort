require 'test_helper'

class UserResourcesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_resources_create_url
    assert_response :success
  end

end
