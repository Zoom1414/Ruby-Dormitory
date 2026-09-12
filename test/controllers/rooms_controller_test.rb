require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    post login_path, params: { email: "admin@dormitory.local", password: "dormitory123" }
    get rooms_path
    assert_response :success
  end
end
