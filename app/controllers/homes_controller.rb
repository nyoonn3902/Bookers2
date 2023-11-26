class HomesController < ApplicationController
  def new
  end
  
  def create
    flash[:notice] = "Signed out successfully."
    redirect_to root_path
    
  end

  def index
  end

  def show
  end

  def edit
  end
end
