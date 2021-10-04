class UsersController < ApplicationController
  def follows
    @user = User.find(params[:id])
    @users = @user.followings.order(created_at: :desc).page(params[:page]).per(15)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.order(created_at: :desc).page(params[:page]).per(15)
  end
end
