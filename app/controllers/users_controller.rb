class UsersController < ApplicationController
  before_action :is_matching_login_user, only:[:edit]

  def show
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to book_path
    else
      render :show
    end
  end


  def edit

    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
     flash[:notice] = "You have updated user successfully."
    redirect_to user_path(user.id)
  end

  def index
    @user = current_user
    @users = User.all
  end

private
  def user_params
    params.require(:user).permit( :name, :introduction )
  end
end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(user.id)
    end
  end