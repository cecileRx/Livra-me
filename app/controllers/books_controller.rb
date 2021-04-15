class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit,:update, :destroy]

  def show
  end

  def index
    @books = Book.paginate(page: params[:page], per_page: 2)
  end

  def new
    if logged_in?
     @book = Book.new
    else
     redirect_to root_path
    end
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "#{@book.title} was created successfully!"
      redirect_to @book
    else
     render 'new'
    end
  end

  def update
    if @book.update(book_params)
      flash[:notice] = "#{@book.title} was edited successfully!"
      redirect_to @book
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description)
  end

  def require_same_user
    unless @book.user == current_user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to books_path
    end

  end
end
