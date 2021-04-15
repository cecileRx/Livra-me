class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
    @books = @user.books
  end

  def index
    @users = User.all
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Your account was successfully created"
      redirect_to books_path
    else
      flash[:alert] = "There is a problem with your account creation"
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your account has been successfully updated"
      redirect_to books_path
    else
      flash[:alert] = "There is a problem with your account update"
      render 'edit'
    end
  end

 private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
