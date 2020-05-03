require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get static_pages_welcome_url
    assert_response :success
  end

  test "should get users" do
    get static_pages_users_url
    assert_response :success
  end

  test "should get confirmation_queue" do
    get static_pages_confirmation_queue_url
    assert_response :success
  end

  test "should get best_posts" do
    get static_pages_best_posts_url
    assert_response :success
  end

  test "should get top_users" do
    get static_pages_top_users_url
    assert_response :success
  end

  test "should get banned_users" do
    get static_pages_banned_users_url
    assert_response :success
  end

end
