require 'test_helper'

class StoryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get story_show_url
    assert_response :success
  end

end
