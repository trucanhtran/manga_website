require "test_helper"

class ChapterControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get chapter_show_url
    assert_response :success
  end
end
