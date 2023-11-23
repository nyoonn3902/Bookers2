class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    book = Book.new(book_params)
    book.user_id = current_user.id
    book.save
    redirect_to book_path(book.id)
  end

  def index
    @user = current_user
    @book = Book.all
  end

  def show
    @user = current_user
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    book = Book.find(params[:id])
    book.user_id = current_user.id
    book.destroy
    redirect_to books_path(book.id)
  end

private
  def book_params
    params.require(:book).permit(:title, :body )
  end

end