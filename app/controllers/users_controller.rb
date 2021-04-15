class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user , only: [:edit, :update, :destroy]

  def show
    @books = @user.books.paginate(page: params[:page], per_page: 2)
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 2)
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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
      redirect_to @user
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

   def require_same_user
    unless @user == current_user
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to users_path
    end
  end
end
