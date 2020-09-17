require 'test_helper'

class GamesUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get games_users_edit_url
    assert_response :success
  end

  test "should get update" do
    get games_users_update_url
    assert_response :success
  end

end
