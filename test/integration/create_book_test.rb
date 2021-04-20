require 'test_helper'

class CreateBookTest < ActionDispatch::IntegrationTest

  setup do
    @book = Book.create(title: "mytestbook", description: "a dummy one")
    @user = User.create(email: "lolo@mail.com", username: "lolo", password: "password", admin: "true")
  end

  test "get the new book form and create book" do
    sign_in_as(@user)
    get new_book_url
    assert_response :success
    assert_difference 'Book.count', 1 do
      post books_url, params: { book: { title: "another title", description: "another description"  } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "another title", response.body
  end

  test "get the new book form and reject book submission" do
    sign_in_as(@user)
    get new_book_url
    assert_response :success
    assert_no_difference 'Book.count' do
      post books_url, params: { book: { title: "", description: "another description"  } }
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match "errors", response.body
  end

end
