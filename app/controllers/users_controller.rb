class UsersController < ApplicationController

  def show
    @users = User.all
    @user = User.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    book.update
    redirect_to user_path(book.id)
  end

  def index
    @users = User.all
    @user = User.find(params[:id])
  end

private
  def user_params
    params.require(:user).permit(:title, :body )
  end
end
