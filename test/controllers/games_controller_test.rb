require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get main" do
    get games_main_url
    assert_response :success
  end

end
