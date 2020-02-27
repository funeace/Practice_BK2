class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.unfollow(@user)
      flash[:notice] = "成功"
    else
      flash[:notice] = "失敗"
    end
      redirect_to user_path(@user)
  end

end
