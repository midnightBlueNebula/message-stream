require 'test_helper'

class StreamsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get streams_show_url
    assert_response :success
  end

  test "should get post_message" do
    get streams_post_message_url
    assert_response :success
  end

end
