class UsersController < ApplicationController

  def show
    @users = User.all
    @user = User.find(params[:id])
  end


  def edit
  end

  def index
  end

private
  def user_params
    params.require(:user).permit(:title, :body )
  end
end
