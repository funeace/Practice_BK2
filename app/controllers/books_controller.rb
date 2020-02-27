class BooksController < ApplicationController
  before_action :authenticate_user!

  def create
    # 投稿するデータと、データベースを紐づける処理
    book = current_user.books.new(book_params)
    book.save
    redirect_to book_path(book)
  end

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user

    @books = @book.book_comments.all
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title,:body)
  end

end
