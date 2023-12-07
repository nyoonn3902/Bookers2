class UsersController < ApplicationController
  before_action :is_matching_login_user, only:[:edit]

  def show
    @users = User.all
    @user = User.find(params[:id])
    @books = @user.books
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end 
        end 
      end 
      if @isRoom
      else
      @room = Room.new
      @entry = Entry.new
      end 
    end 
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
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def index
    @user = current_user
    @users = User.all
  end

private
  def user_params
    params.require(:user).permit( :name, :introduction, :profileimage )
  end
end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end