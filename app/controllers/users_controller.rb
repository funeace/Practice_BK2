class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books.all
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user)
    end
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(current_user.id)
  end

  def favorites
    @user = User.find(params[:id])
    @books = @user.favorite_books
  end

  def following
    @user = User.find(params[:id])
    @users = @user.followings
  end

  def follower
    @user = User.find(params[:id])
    @users = @user.followers
  end


# ストロングパラメータ
  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end
