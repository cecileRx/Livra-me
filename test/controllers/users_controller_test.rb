require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: "lolo@mail.com", username: "lolo", password: "password", admin: "true")
  end

  test "should get new" do
    get signup_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_url, params: { user: { username: "peter", password: "helloworld", email: "peter@mail.com"  } }
    end

    assert_redirected_to books_url
  end
end
