class BooksController < ApplicationController
before_action :is_matching_login_user, only:[:edit]

  def new
    @book = Book.new
  end

  def index
    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.all.sort {|a,b|
    b.favorites.where(created_at: from...to).size <=>
    a.favorites.where(created_at: from...to).size
    }

    @user = current_user
    @book_new = Book.new
  end

  def show
    @books = Book.all
    @user = current_user
    @book_new = Book.new
    @book = Book.find(params[:id])
    unless ReadCount.where(created_at: Time.zone.now.all_day).find_by(user_id: current_user.id, book_id: @book.id)
      current_user.read_counts.create(book_id: @book.id)
    end
    @book_comment = BookComment.new
  end

  def create
    @books = Book.all
    @user = current_user
    @book_new = Book.new(book_params)
    @book_new.user_id = current_user.id
    if @book_new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book_new.id)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @user = current_user
    @book = Book.find(params[:id])
     @book.update(book_params)
    if @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

private
  def book_params
    params.require(:book).permit(:title, :body )
  end

def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
end
end