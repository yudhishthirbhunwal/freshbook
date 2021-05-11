require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:admin)
    @other_user = users(:one)
  end

  test "should redirect index when not signed in" do
    get users_path
    assert_response :redirect 
  end

  test "should redirect show when not signed in" do
    get user_path(@user)
    assert_response :redirect
  end
  
end
