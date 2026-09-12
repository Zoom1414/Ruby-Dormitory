require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to login" do
    get rooms_path
    assert_redirected_to login_path
  end

  test "allows the admin to sign in" do
    post login_path, params: { email: "admin@dormitory.local", password: "dormitory123" }
    assert_redirected_to root_path
  end

  test "rejects invalid credentials" do
    post login_path, params: { email: "wrong@example.com", password: "wrong" }
    assert_response :unprocessable_entity
  end
end