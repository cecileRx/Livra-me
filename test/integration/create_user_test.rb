require 'test_helper'

class CreateUserTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(email: "lolo@mail.com", username: "lolo", password: "password", admin: "true")
  end

  test "get the new user form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_url, params: { user: { username: "peter", password: "helloworld", email: "peter@mail.com"  } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "peter", response.body
  end

  test "get the new user form and reject signup submission" do
    get "/signup"
    assert_response :success
    assert_no_difference 'Category.count' do
      post users_path, params: { user: { username: "rodolf", password: "helloworld" } }
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match "errors", response.body
  end

end
