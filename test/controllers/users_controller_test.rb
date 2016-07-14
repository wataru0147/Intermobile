require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should get view_all" do
    get :view_all
    assert_response :success
  end

end
