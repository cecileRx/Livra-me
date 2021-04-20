require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = Book.create(title: "mytestbook", description: "a dummy one")
    @user = User.create(email: "lolo@mail.com", username: "lolo", password: "password", admin: "true")
  end

  test "should get new" do
    sign_in_as(@user)
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    sign_in_as(@user)
    assert_difference('Book.count', 1) do
      post books_url, params: { book: { title: "another title", description: "another description"  } }
    end

    assert_redirected_to book_url(Book.last)
  end
end
