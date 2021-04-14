class UsersController < ApplicationController

  def show
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

 private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

end
